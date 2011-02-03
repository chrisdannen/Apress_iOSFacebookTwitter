//
//  HelloFacebookView.m
//  HelloFacebook
//
//  Created by Christopher White on 1/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelloFacebookView.h"
#import "AppDelegate_iPhone.h"

@implementation HelloFacebookView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		self.backgroundColor = [UIColor whiteColor];
		
		/*
		NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
		[params setObject:@"users.getInfo" forKey:@"method"];
		[params setObject:@"19292868552" forKey:@"uid"];
		[facebook requestWithParams:params andDelegate:self];
		[params release];
		*/
		 
		[facebook requestWithGraphPath:@"19292868552" andDelegate:self];
    }
    return self;
}

#pragma mark -
#pragma mark FBRequestDelegate

/**
 * Called just before the request is sent to the server.
 */
- (void)requestLoading:(FBRequest *)request {
	NSLog(@"requestLoading");
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/**
 * Called when the server responds and begins to send back data.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"request didReceiveResponse");
}

/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	NSLog(@"request didFailWithError");
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/**
 * Called when a request returns and its response has been parsed into an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number, depending
 * on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
	NSLog(@"request didLoad");
	
	NSDictionary *dictionary = (NSDictionary*)result;
	
	UILabel *label = [[UILabel alloc] initWithFrame:self.frame];
	label.text = [dictionary description];
	[self addSubview:label];
	[label release];
}

/**
 * Called when a request returns a response.
 *
 * The result object is the raw response from the server of type NSData
 */
- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data {
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	NSLog(@"request didLoadRawResponse");
}

- (void)dealloc {
    [super dealloc];
}


@end
