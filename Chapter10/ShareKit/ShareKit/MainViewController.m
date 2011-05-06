//
//  MainViewController.m
//  ShareKit
//
//  Created by Christopher White on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "SHK.h"

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)share
{
    NSString *longURL = @"http://www.apress.com";
    NSString *apiEndpoint = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@", longURL];
    NSString *shortURL = [NSString stringWithContentsOfURL:[NSURL URLWithString:apiEndpoint]
                                                  encoding:NSASCIIStringEncoding
                                                     error:nil];
    //NSLog(@"Long: %@ - Short: %@",url1,shortURL);

    
    
	// Create the item to share (in this example, a url)
	NSURL *url = [NSURL URLWithString:@"http://www.apress.com"];
	SHKItem *item = [SHKItem URL:url title:@"Apress is Awesome!"];
    
	// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    
	// Display the action sheet
	[actionSheet showFromToolbar:toolbar];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView 
{
	[super loadView];
	
	self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                          target:self 
                                                                          action:@selector(share)];
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:item];
    [item release];
    
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, self.view.bounds.size.height-40.0f, self.view.bounds.size.width, 40.0f)];
    
    [toolbar setItems:items animated:YES];
    [self.view addSubview:toolbar];
    [toolbar release];
    
    [SHK flushOfflineQueue];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
