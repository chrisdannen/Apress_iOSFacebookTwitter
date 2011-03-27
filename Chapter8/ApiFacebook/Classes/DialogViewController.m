    //
//  DialogViewController.m
//  ApiFacebook
//
//  Created by Christopher White on 2/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DialogViewController.h"
#import "FBLoginButton.h"
#import "AppDelegate.h"

@implementation DialogViewController

- (id)init {
	self = [super init];
	if (self != nil) {
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Dialog" image:nil tag:0] autorelease];
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

	[fbLoginButton updateImage];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBAction

/**
 * Called on a login/logout button click.
 */
- (void)fbButtonClick:(UIButton*)sender {
	//show a dialog with just an empty text box to post anything
	NSMutableDictionary * params = [NSMutableDictionary dictionary];
	[facebook dialog:@"feed" andParams:params andDelegate:self];
	
	//show a dialog to a youtube link
	/*
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"http://www.youtube.com/watch?v=nqMc9B7uDV8", @"link",
								   nil];
	
	[facebook dialog:@"feed" andParams:params andDelegate:self];
	 */

	//spice it up a bit
	/*
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"http://developers.facebook.com/docs/reference/dialogs/", @"link",
								   @"http://fbrell.com/f8.jpg", @"picture",
								   @"Facebook Dialogs", @"name",
								   @"Reference Documentation", @"caption",
								   @"Dialogs provide a simple, consistent interface for apps to interact with users.", @"description",
								   @"Facebook Dialogs are so easy!",  @"message",
								   nil];
	
	[facebook dialog:@"feed" andParams:params andDelegate:self];
	 */
	
	//oauth dialog is handled via authorize call but you can also do it this way
	//NOTE: None of the FBDialogDelegate methods will be called when using this dialog.
	/*
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"<your app id here>", @"client_id",
								   nil];
	[facebook dialog:@"oauth" andParams:params andDelegate:self];
	 */
	
	//friends dialog is NOT supported
	//hits delegate callback dialogCompleteWithUrl: with URL of 
	//fbconnect://success/?error_code=3&error_msg=This+method+isn%27t+supported+for+this+display+type

	/*
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"<friend id>", @"id",
								   nil];
	[facebook dialog:@"friends" andParams:params andDelegate:self];
	 */
	
	//pay dialog is not supported
	
	//requests dialog is not supported
}

#pragma mark
#pragma mark FBDialogDelegate

/**
 * Called when the dialog succeeds and is about to be dismissed.
 */
- (void)dialogDidComplete:(FBDialog *)dialog {
	NSLog(@"dialogDidComplete:");
}

/**
 * Called when the dialog succeeds with a returning url.
 */
- (void)dialogCompleteWithUrl:(NSURL *)url {
	NSLog(@"dialogCompleteWithUrl:");
}

/**
 * Called when the dialog get canceled by the user.
 */
- (void)dialogDidNotCompleteWithUrl:(NSURL *)url {
	NSLog(@"dialogDidNotCompleteWithUrl:");
}

/**
 * Called when the dialog is cancelled and is about to be dismissed.
 */
- (void)dialogDidNotComplete:(FBDialog *)dialog {
	NSLog(@"dialogDidNotComplete:");
}

/**
 * Called when dialog failed to load due to an error.
 */
- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error {
	NSLog(@"dialog:didFailWithError:");
}

/**
 * Asks if a link touched by a user should be opened in an external browser.
 *
 * If a user touches a link, the default behavior is to open the link in the Safari browser,
 * which will cause your app to quit.  You may want to prevent this from happening, open the link
 * in your own internal browser, or perhaps warn the user that they are about to leave your app.
 * If so, implement this method on your delegate and return NO.  If you warn the user, you
 * should hold onto the URL and once you have received their acknowledgement open the URL yourself
 * using [[UIApplication sharedApplication] openURL:].
 */
- (BOOL)dialog:(FBDialog*)dialog shouldOpenURLInExternalBrowser:(NSURL *)url {
	NSLog(@"dialog:shouldOpenURLInExternalBrowser:");
	return YES;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
