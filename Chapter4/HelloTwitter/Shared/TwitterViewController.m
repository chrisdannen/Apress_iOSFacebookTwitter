    //
//  TwitterViewController.m
//  HelloTwitter
//
//  Created by Christopher White on 1/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterViewController.h"
#import "HelloTwitterView.h"

@implementation TwitterViewController

- (void)loadView {
	[super loadView];
	
	HelloTwitterView	*helloTwitterView	= [[HelloTwitterView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:helloTwitterView];
	[helloTwitterView release];
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
