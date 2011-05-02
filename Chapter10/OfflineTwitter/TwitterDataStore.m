//
//  TwitterDataStore.m
//  OfflineTwitter
//
//  Created by Christopher White on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterDataStore.h"
#import <CoreData/CoreData.h>
#import "Tweet.h"

@implementation TwitterDataStore

- (NSArray*)tweets 
{
    return nil;
}

- (void)deleteTweets
{
    
}

- (void)synchronizeTweets:(NSArray*)tweets
{

}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)dealloc
{
    [super dealloc];
}

@end
