    //
//  LoginViewController.m
//  OAuthFacebook
//
//  Created by Christopher White on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "FBLoginButton.h"
#import "AppDelegate.h"

@implementation LoginViewController

- (id)init {
	self = [super init];
	if (self != nil) {
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Login" image:nil tag:0] autorelease];
	}
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	fbLoginButton = [[FBLoginButton alloc] initWithFrame:CGRectMake(127.0f, 68.0f, 72.0f, 37.0f)];
	fbLoginButton.backgroundColor = [UIColor clearColor];
	[fbLoginButton addTarget:self action:@selector(fbButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:fbLoginButton];
	[fbLoginButton release];
	
	fbLoginButton.isLoggedIn = NO;
	if (YES == [facebook isSessionValid]) {
		fbLoginButton.isLoggedIn = YES;
	}
	[fbLoginButton updateImage];
}

/**
 * Show the authorization dialog.
 */
- (void)login {
	[facebook authorize:[NSArray arrayWithObjects:@"user_groups", @"user_events", @"offline_access",nil] delegate:self];
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
	[facebook logout:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBAction

/**
 * Called on a login/logout button click.
 */
- (void)fbButtonClick:(UIButton*)sender {
	if (fbLoginButton.isLoggedIn) {
		[self logout];
	} else {
		[self login];
	}
}

#pragma mark -
#pragma mark FBSessionDelegate

//Called when the user successfully logged in.
- (void)fbDidLogin {
	NSLog(@"did login");
	
	fbLoginButton.isLoggedIn = YES;
	[fbLoginButton updateImage];
}

//Called when the user dismissed the dialog without logging in.
- (void)fbDidNotLogin:(BOOL)cancelled {
	NSLog(@"did not login");
}

//Called when the user logged out.
- (void)fbDidLogout {
	NSLog(@"did logout");
	
	fbLoginButton.isLoggedIn = NO;
	[fbLoginButton updateImage];
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

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
