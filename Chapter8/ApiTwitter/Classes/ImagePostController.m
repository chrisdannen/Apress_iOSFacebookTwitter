//
//  ImagePostController.m
//  ApiFacebook
//
//  Created by Christopher White on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImagePostController.h"
#import "TwitterLoginButton.h"

@implementation ImagePostController

- (id)init {
	self = [super init];
	if (self != nil) {
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Image" image:nil tag:1] autorelease];
	}
	return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView 
{
    [super loadView];

    self.view.backgroundColor = [UIColor whiteColor];

    twitterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	twitterButton.frame = CGRectMake(127.0f, 68.0f, 72.0f, 37.0f);
	[twitterButton setTitle:@"Twitter" forState:UIControlStateNormal];
	[twitterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[twitterButton addTarget:self action:@selector(twitterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:twitterButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)twitterButtonClick:(UIButton*)sender {
    if (YES == [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *uiImagePickerController = [[UIImagePickerController alloc] init];
        uiImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        uiImagePickerController.delegate = self;
        [self presentModalViewController:uiImagePickerController animated:YES];
        [uiImagePickerController release];
    }
}

#pragma mark - UIImagePickerControllerDelegate

// The picker does not dismiss itself; the client dismisses it in these callbacks.
// The delegate will receive one or the other, but not both, depending whether the user
// confirms or cancels.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
    [savedImage release];
    savedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissModalViewControllerAnimated:YES];
    
    //upload the image via twitpic
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker 
{
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [savedImage release];
    [super dealloc];
}

@end
