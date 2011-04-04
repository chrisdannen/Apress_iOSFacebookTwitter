//
//  OfflineTwitterAppDelegate.m
//  OfflineTwitter
//
//  Created by Christopher White on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OfflineTwitterAppDelegate.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "TimelineViewController.h"

#define kOAuthConsumerKey				@""		//REPLACE ME
#define kOAuthConsumerSecret			@""		//REPLACE ME

SA_OAuthTwitterEngine	*sa_OAuthTwitterEngine;

@implementation OfflineTwitterAppDelegate

@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    sa_OAuthTwitterEngine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
	sa_OAuthTwitterEngine.consumerKey = kOAuthConsumerKey;
	sa_OAuthTwitterEngine.consumerSecret = kOAuthConsumerSecret;
    
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
	window = [[UIWindow alloc] initWithFrame:screenBounds];
	
    // Override point for customization after application launch.
	mainViewController = [[MainViewController alloc] init];
	
	NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
	[viewControllers addObject:[[LoginViewController alloc] init]];
	[viewControllers addObject:[[TimelineViewController alloc] init]];
	mainViewController.viewControllers = viewControllers;
	[viewControllers release];
	
    if ([window respondsToSelector:@selector(setRootViewController:)]) {
		[window setRootViewController:mainViewController];
	} else {
		[window addSubview:mainViewController.view];
	}
	
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark -
#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

- (void) twitterOAuthConnectionFailedWithData: (NSData *) data {
	NSLog(@"twitterOAuthConnectionFailedWithData");
}

#pragma mark -
#pragma mark MGTwitterEngineDelegate methods

- (void)requestSucceeded:(NSString *)connectionIdentifier {
    NSLog(@"Request succeeded for connectionIdentifier = %@", connectionIdentifier);
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error {
    NSLog(@"Request failed for connectionIdentifier = %@, error = %@ (%@)", 
          connectionIdentifier, 
          [error localizedDescription], 
          [error userInfo]);
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)connectionIdentifier {
	NSLog(@"Status received for connectionIdentifier = %@, %@", connectionIdentifier, [statuses description]);
    
    
    NSDictionary *userInfoDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:statuses, nil] forKeys:[NSArray arrayWithObjects:@"tweets", nil]];
	[[NSNotificationCenter defaultCenter] postNotificationName:connectionIdentifier 
														object:self 
													  userInfo:userInfoDictionary];
	
	NSDictionary *dictionary = [statuses objectAtIndex:0];
	if (dictionary) {
		NSString *twitterID = [dictionary objectForKey:@"id"];
		NSLog(@"TwitterID = %@", twitterID);
	}
}

- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)connectionIdentifier {
	NSLog(@"Direct message for connectionIdentifier = %@", connectionIdentifier);
}

- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)connectionIdentifier {
	NSLog(@"User info for connectionIdentifier = %@", connectionIdentifier);
	
	//tell the UI to update itself
	
	NSDictionary *userInfoDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userInfo, nil] forKeys:[NSArray arrayWithObjects:@"followers", nil]];
	[[NSNotificationCenter defaultCenter] postNotificationName:connectionIdentifier 
														object:self 
													  userInfo:userInfoDictionary];
}

- (void)miscInfoReceived:(NSArray *)miscInfo forRequest:(NSString *)connectionIdentifier {
	NSLog(@"Misc info for connectionIdentifier = %@", connectionIdentifier);
}

- (void)socialGraphInfoReceived:(NSArray *)socialGraphInfo forRequest:(NSString *)connectionIdentifier {
	NSLog(@"Social graph for connectionIdentifier = %@", connectionIdentifier);
}

- (void)accessTokenReceived:(OAToken *)token forRequest:(NSString *)connectionIdentifier {
	NSLog(@"Access token for connectionIdentifier = %@", connectionIdentifier);
}

- (void)imageReceived:(UIImage *)image forRequest:(NSString *)connectionIdentifier {
	NSLog(@"Image receieved for connectionIdentifier = %@", connectionIdentifier);
	
	NSDictionary *userInfoDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:image, nil] forKeys:[NSArray arrayWithObjects:@"profile_image", nil]];
	[[NSNotificationCenter defaultCenter] postNotificationName:connectionIdentifier 
														object:self 
													  userInfo:userInfoDictionary];
}

- (void)connectionStarted:(NSString *)connectionIdentifier {
	NSLog(@"Connection started for connectionIdentifier = %@", connectionIdentifier);
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)connectionFinished:(NSString *)connectionIdentifier {
	NSLog(@"Connection finished for connectionIdentifier = %@", connectionIdentifier);
}

- (void)dealloc
{
    [mainViewController release];
    [window release];
	[sa_OAuthTwitterEngine release];
    [super dealloc];
}

@end
