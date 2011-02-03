    //
//  HelloFacebookViewController.m
//  HelloFacebook
//
//  Created by Christopher White on 1/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelloFacebookViewController.h"
#import "HelloFacebookView.h"

@implementation HelloFacebookViewController

- (id)init {
	if (self = [super init]) {
	}
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];

	HelloFacebookView	*helloFacebookView	= [[HelloFacebookView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:helloFacebookView];
	[helloFacebookView release];
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
