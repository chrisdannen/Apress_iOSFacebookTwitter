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

//do one request at a time...monitor the queue on a separate thread...
//check the queue on a separate thread and if the queue is not empty, then take the next one off of the queue and issue a request for it on the main thread

- (void)issueRequest:(NSString*)path
{
    [facebook requestWithGraphPath:path andDelegate:self];
}

- (void)dequeueNextRequest
{
    //only want to dequeue the next request if we're not currently processing a request
    
    NSString *currentPath = nil;
    
    if (NO == handlingRequest) {
        @synchronized(self) {
            if (0 < [requestQueue count]) {
                currentPath = [requestQueue dequeue];
            }
        }
        
        if (currentPath) {
            handlingRequest = YES;
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
            [dictionary setObject:currentPath forKey:@"path"];
            
            self.currentRequestDictionary = dictionary;
            
            [self performSelectorOnMainThread:@selector(issueRequest:) withObject:currentPath waitUntilDone:NO];
        }
    }
}

- (void)processQueue:(id)object
{
    while (TRUE) {
        [[FacebookRequestController sharedRequestController] dequeueNextRequest];
        
        [NSThread sleepForTimeInterval:.01];
    }
}

- (void)enqueueRequestWithGraphPath:(NSString*)path
{
    if (nil == requestQueue) {
        requestQueue = [[NSMutableArray array] retain];
        
        [self performSelectorInBackground:@selector(processQueue:) withObject:nil];
    }

    @synchronized(self) {
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
    
    handlingRequest = NO;
}

/**
 * Called when a request returns and its response has been parsed into an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number, depending
 * on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
	NSLog(@"didLoad:");
	
	//post a notification with the current dictionary
    //issue notification to whoever registered for the given path and include the result response
    
    handlingRequest = NO;
    
    NSDictionary *userInfoDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:result, nil] forKeys:[NSArray arrayWithObjects:@"result", nil]];
    
    NSString *path = [self.currentRequestDictionary objectForKey:@"path"];
	[[NSNotificationCenter defaultCenter] postNotificationName:path 
														object:self 
													  userInfo:userInfoDictionary];
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
