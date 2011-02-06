//
//  MainView.m
//  HelloTwitter
//
//  Created by Christopher White on 1/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"
#import "AppDelegate.h"

NSString	*consumerKey	= @"mwYFyb413NKPsHG1x5fIg";
NSString	*consumerSecret = @"YAC11azdSXaIOxCo1j5KAeigSi7zr6pyzQ4jl3YT9A4";
NSString	*requestURL		= @"http://twitter.com/oauth/request_token";
NSString	*accessURL		= @"http://twitter.com/oauth/access_token";
NSString	*authorizeURL	= @"http://twitter.com/oauth/authorize";

@implementation MainView

@synthesize webView;

- (NSString *)generateNonce {
	NSNumber *number = [NSNumber numberWithUnsignedLongLong:((unsigned long long)arc4random()) << 32 | (unsigned long long)arc4random()];
	return [number description];
}

- (NSString *)generateTimestamp {
	NSNumber *number = [NSNumber numberWithUnsignedLongLong:(unsigned long long)[[NSDate date] timeIntervalSince1970]];
	return [number description];
}

//
// request token callback
// when twitter sends us a request token this callback will fire
// we can store the request token to be used later for generating
// the authentication URL
//
- (void) setRequestToken: (OAServiceTicket *) ticket withData: (NSData *) data {
	int i = 0;
}

//
// if the fetch fails this is what will happen
// you'll want to add your own error handling here.
//
- (void) outhTicketFailed: (OAServiceTicket *) ticket data: (NSData *) data {
	int i = 0;
}

- (void)oaCallFinishedwithObject:(OACall *)oaCall withObject:(NSString*)body {
	int i = 0;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
		
		webView = [[UIWebView alloc] initWithFrame:frame];
		webView.delegate = self;
		[self addSubview:webView];
		[webView release];

		//method 1: use OACall?
		/*
		OAConsumer *oaConsumer = [[OAConsumer alloc] initWithKey:consumerKey  
														  secret:consumerSecret];
		
		OACall *oaCall = [[OACall alloc] initWithURL:[NSURL URLWithString:requestURL]];
		[oaCall perform:oaConsumer 
				  token:nil 
				  realm:requestURL 
			   delegate:self 
			  didFinish:@selector(oaCallFinishedwithObject:withObject:)];
		
		[oaConsumer release];
		 */
		
		//method 2: directly use OAConsumer?
		/*
		OAConsumer *oaConsumer = [[OAConsumer alloc] initWithKey:consumerKey  
														  secret:consumerSecret];
		
		OAMutableURLRequest *oaMutableURLRequest = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestURL] 
																				   consumer:oaConsumer
																				 	  token:nil 
																					  realm:requestURL  
																		  signatureProvider:nil 
																					  nonce:[self generateNonce] 
																				  timestamp:[self generateTimestamp]];
		[oaConsumer release];
		
		OADataFetcher				*fetcher = [[[OADataFetcher alloc] init] autorelease];	
		[fetcher fetchDataWithRequest:oaMutableURLRequest 
							 delegate:self 
					didFinishSelector:@selector(setRequestToken:withData:) 
					  didFailSelector:@selector(outhTicketFailed:data:)];
		 */
    }
    return self;
}

#pragma mark -
#pragma mark UIWebViewDelegate methods

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	int i = 0;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	int i = 0;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	int i = 0;
}

#pragma mark -
#pragma mark OACallDelegate methods

- (void)call:(OACall *)call failedWithError:(NSError *)error {
	int i = 0;
}

- (void)call:(OACall *)call failedWithProblem:(OAProblem *)problem {
	int i = 0;
}

- (void)dealloc {
    [super dealloc];
}


@end
