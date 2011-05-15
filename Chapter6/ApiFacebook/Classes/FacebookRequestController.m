//
//  FacebookRequestController.m
//  ApiFacebook
//
//  Created by Christopher White on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookRequestController.h"
#import "NSMutableArray+QueueAdditions.h"
#import "AppDelegate.h"

static FacebookRequestController *sharedRequestController;

@implementation FacebookRequestController

@synthesize currentRequestDictionary;

+ (FacebookRequestController*)sharedRequestController
{
    if (nil == sharedRequestController) {
        sharedRequestController = [[FacebookRequestController alloc] init];
    }
    
    return sharedRequestController;
}

- (void)dealloc
{
    [currentRequestDictionary release];
    
    [requestQueue release];
    
    [super dealloc];
}

- (void)issueRequest:(NSString*)path
{
    [facebook requestWithGraphPath:path andDelegate:self];
}

- (NSString*)nextRequestPath
{
    NSString *currentPath = nil;
    
    if (0 < [requestQueue count]) {
        currentPath = [requestQueue objectAtIndex:0];
    }
    
    return currentPath;
}

- (void)performRequest:(NSString*)path
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:path forKey:@"path"];
    
    self.currentRequestDictionary = dictionary;
    
    [self issueRequest:path];
}

- (void)enqueueRequestWithGraphPath:(NSString*)path
{
    if (nil == requestQueue) {
        requestQueue = [[NSMutableArray array] retain];
    }
    
    //if there are no requests in the queue, then add it to the queue and make the request...otherwise, add it to the queue
    if (0 == [requestQueue count]) {

        [requestQueue enqueue:path];
        
        [self performRequest:path];
    } else {
        [requestQueue enqueue:path];
    }
}

#pragma mark -
#pragma mark FBRequestDelegate

- (void)requestLoading:(FBRequest *)request {
	NSLog(@"requestLoading:");
}

/**
 * Called when the server responds and begins to send back data.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"didReceiveResponse:");
}

/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError:");
    
    [requestQueue dequeue];
    
    NSString *nextRequest = [[self nextRequestPath] retain];
    if (nextRequest) {
        [self performRequest:nextRequest];
    }
    [nextRequest release];
}

/**
 * Called when a request returns and its response has been parsed into an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number, depending
 * on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
	NSLog(@"didLoad:");
    
    NSDictionary *userInfoDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:result, nil] forKeys:[NSArray arrayWithObjects:@"result", nil]];
    
    NSString *path = [self.currentRequestDictionary objectForKey:@"path"];
	[[NSNotificationCenter defaultCenter] postNotificationName:path 
														object:self 
													  userInfo:userInfoDictionary];

    [requestQueue dequeue];
    
    NSString *nextRequest = [[self nextRequestPath] retain];
    if (nextRequest) {
        [self performRequest:nextRequest];
    }
    [nextRequest release];
}

/**
 * Called when a request returns a response.
 *
 * The result object is the raw response from the server of type NSData
 */
- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data {
	NSLog(@"didLoadRawResponse:");
}


@end
