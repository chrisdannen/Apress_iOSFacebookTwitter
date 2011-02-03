    //
//  FacebookViewController.m
//  OAuthFacebook
//
//  Created by Christopher White on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookViewController.h"
#import "OAuthFacebookView.h"

@implementation FacebookViewController

- (id)init {
	if (self = [super init]) {
	}
	return self;
}

- (void)loadView {
	[super loadView];
	
	OAuthFacebookView	*oauthFacebookView	= [[OAuthFacebookView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:oauthFacebookView];
	[oauthFacebookView release];
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
