    //
//  LoginViewController.m
//  ApiTwitter
//
//  Created by Christopher White on 2/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "OfflineTwitterAppDelegate.h"
#import "TwitterLoginButton.h"

@implementation LoginViewController

- (id)init {
	self = [super init];
	if (self != nil) {
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Login" image:nil tag:0] autorelease];
	}
	return self;
}

- (void) loadView {
	[super loadView];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	twitterLoginButton = [[TwitterLoginButton alloc] initWithFrame:CGRectMake(127.0f, 68.0f, 72.0f, 37.0f)];
	twitterLoginButton.backgroundColor = [UIColor clearColor];
	[twitterLoginButton addTarget:self action:@selector(twitterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:twitterLoginButton];
	[twitterLoginButton release];
	
	twitterLoginButton.isLoggedIn = NO;
	if (YES == [sa_OAuthTwitterEngine isAuthorized])
		twitterLoginButton.isLoggedIn = YES;
	[twitterLoginButton updateImage];
}

/**
 * Show the authorization dialog.
 */
- (void)login {
	
	UIViewController			*controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: sa_OAuthTwitterEngine delegate: self];
	if (controller) 
		[self presentModalViewController: controller animated: YES];
	else {
		[sa_OAuthTwitterEngine sendUpdate: [NSString stringWithFormat: @"Already Updated. %@", [NSDate date]]];
	}
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
	
	[sa_OAuthTwitterEngine clearAccessToken];
	
	twitterLoginButton.isLoggedIn = NO;
	[twitterLoginButton updateImage];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBAction

/**
 * Called on a login/logout button click.
 */
- (void)twitterButtonClick:(UIButton*)sender {
	if (twitterLoginButton.isLoggedIn) {
		[self logout];
	} else {
		[self login];
	}
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark
#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	NSLog(@"Authenicated for %@", username);
	
	twitterLoginButton.isLoggedIn = YES;
	[twitterLoginButton updateImage];
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Failed!");
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Canceled.");
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
