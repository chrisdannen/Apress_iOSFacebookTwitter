//
//  OfflineTwitterTest.m
//  OfflineTwitterTest
//
//  Created by Christopher White on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OfflineTwitterTest.h"
#import "TwitterDataStore_SQLite.h"

@implementation OfflineTwitterTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    twitterDataStore = [[TwitterDataStore_SQLite alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    [twitterDataStore release];
    
    [super tearDown];
}

- (void)testItShouldSynchronizeTweets
{
    //pass in an array of NSDictionary's of Tweets.
    //then get the Tweets back and confirm they are there
    
    [twitterDataStore deleteTweets];
    
    NSDictionary *tweetDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1", @"This is a test tweet!", nil] forKeys:[NSArray arrayWithObjects:@"id", @"text", nil]];
    NSArray *newTweets = [NSArray arrayWithObject:tweetDictionary];
    [twitterDataStore synchronizeTweets:newTweets];
    
    NSArray *tweets = [twitterDataStore tweets];
    STAssertTrue((1 == [tweets count]), @"There should be 1 tweet in the database");
}

@end
