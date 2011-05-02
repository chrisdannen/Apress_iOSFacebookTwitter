//
//  TwitterDataStore_SQLite.m
//  OfflineTwitter
//
//  Created by Christopher White on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterDataStore_SQLite.h"
#import "sqlite3.h"
#import "Tweet.h"

@interface TwitterDataStore_SQLite ()
- (void)openDatabase;
- (void)closeDatabase;
@end

@implementation TwitterDataStore_SQLite

- (id)init 
{
    if ((self = [super init])) {
        [self openDatabase];
    }
    return self;
}

- (void)openDatabase
{
    if (nil == database) {
        NSURL *path = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"twitter.sqlite"];

        if (SQLITE_OK != sqlite3_open([[path relativePath] UTF8String], &database)) {
            [self closeDatabase];
        } else {
            char		*errmsg;
            
            NSString	*createTables = @"CREATE TABLE IF NOT EXISTS tweets (id INTEGER PRIMARY KEY, message TEXT);";
            if (SQLITE_OK != sqlite3_exec(database, [createTables UTF8String], NULL, NULL, &errmsg)) {
                NSLog(@"create table error: '%s'", errmsg);
            }
            
            NSString	*createIndex = @"CREATE INDEX IF NOT EXISTS tweetIndex ON tweets(id);";
            if (SQLITE_OK != sqlite3_exec(database, [createIndex UTF8String], NULL, NULL, &errmsg)) {
                NSLog(@"create table index error: '%s'", errmsg);
            }
        }
    }
}

- (void)closeDatabase
{
    sqlite3_close(database);
    database = nil;
}

- (NSArray*)tweets 
{
    NSMutableArray *tweets = [NSMutableArray array];
    
    @synchronized(self) {
        
        sqlite3_stmt *queryStatement = nil;
        NSString *tweetsStatement = @"SELECT id, message FROM tweets";
        if (sqlite3_prepare_v2(database, [tweetsStatement UTF8String], -1, &queryStatement, NULL) != SQLITE_OK) {
            NSLog(@"tweets select error: '%s'", sqlite3_errmsg(database));
            return nil;
        }

        while(sqlite3_step(queryStatement) == SQLITE_ROW) {
            
            Tweet *tweet = [[[Tweet alloc] init] autorelease];
            [tweet setId:[NSNumber numberWithLongLong:sqlite3_column_int64(queryStatement, 0)]];
            [tweet setText:[NSString stringWithUTF8String:(const char *)sqlite3_column_text(queryStatement, 1)]];
            [tweets addObject:tweet];
        }
        sqlite3_finalize(queryStatement);
    }
    
    return tweets;
}

- (void)deleteTweets
{
    @synchronized(self) {
        char		*errmsg;
        
        NSString *deleteTweetsStatement = @"DELETE FROM tweets";
        if (sqlite3_exec(database, [deleteTweetsStatement UTF8String], NULL, NULL, &errmsg) != SQLITE_OK) {
            NSLog(@"delete tweets error: '%s'", sqlite3_errmsg(database));
        }
    }
}

- (void)synchronizeTweets:(NSArray*)tweets
{
    NSAutoreleasePool *autoReleasePool = [[NSAutoreleasePool alloc] init];
    
    @synchronized(self) {
        
        [self deleteTweets];
        
        for (NSDictionary *tweetDictionary in tweets) {
            
            sqlite3_exec(database, "BEGIN;", NULL, NULL, NULL);
            
            char *text = "INSERT INTO tweets (id, message) VALUES (?, ?);";
            
            sqlite3_stmt *stmt = NULL;
            if (sqlite3_prepare_v2(database, text, -1, &stmt, NULL) != SQLITE_OK) {
                NSLog(@"synchronizeTweets select error: '%s'", sqlite3_errmsg(database));
                sqlite3_exec(database, "ROLLBACK;", NULL, NULL, NULL);
            }
            
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            NSNumber * tweetId = [f numberFromString:[tweetDictionary objectForKey:@"id"]];
            sqlite3_bind_int64(stmt, 1, [tweetId longLongValue]);
            [f release];
            
            NSString *message = [tweetDictionary objectForKey:@"text"];
            sqlite3_bind_text(stmt, 2, [message UTF8String], -1, SQLITE_TRANSIENT);
            
            BOOL result = sqlite3_step(stmt) != SQLITE_ERROR;
            sqlite3_finalize(stmt);
            
            sqlite3_exec(database, result ? "END;" : "ROLLBACK;", NULL, NULL, NULL);
        }
    }
    
    //post a notification that the tweets are available...have responder update itself on the main thread
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tweetsDidSynchronize" 
														object:self 
													  userInfo:nil];
    
    [autoReleasePool release];
}

- (void)dealloc
{
    [self closeDatabase];
    [super dealloc];
}

@end
