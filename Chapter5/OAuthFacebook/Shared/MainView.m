//
//  MainView.m
//  OAuthFacebook
//
//  Created by Christopher White on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"
#import "FBLoginButton.h"
#import "AppDelegate.h"

@implementation MainView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
		
		fbLoginButton = [[FBLoginButton alloc] initWithFrame:CGRectMake(127.0f, 68.0f, 72.0f, 37.0f)];
		fbLoginButton.backgroundColor = [UIColor clearColor];
		[fbLoginButton addTarget:self action:@selector(fbButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:fbLoginButton];
		[fbLoginButton release];
		
		fbLoginButton.isLoggedIn = NO;
		[fbLoginButton updateImage];
    }
    return self;
}

/**
 * Show the authorization dialog.
 */
- (void)login {
	[facebook authorize:[NSArray arrayWithObjects:@"read_stream", @"offline_access",nil] delegate:self];
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

- (void)dealloc {
    [super dealloc];
}


@end
