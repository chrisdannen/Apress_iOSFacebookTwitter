//
//  ImagePostController.m
//  ApiFacebook
//
//  Created by Christopher White on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImagePostController.h"
#import "FBLoginButton.h"
#import "AppDelegate.h"

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

    fbLoginButton = [[FBLoginButton alloc] initWithFrame:CGRectMake(127.0f, 68.0f, 72.0f, 37.0f)];
    fbLoginButton.backgroundColor = [UIColor clearColor];
    [fbLoginButton addTarget:self action:@selector(fbButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fbLoginButton];
    [fbLoginButton release];

    [fbLoginButton updateImage];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)fbButtonClick:(UIButton*)sender {
    
    //+ (NSArray *)availableMediaTypesForSourceType:(UIImagePickerControllerSourceType)sourceType; // returns array of available media types (i.e. kUTTypeImage)
    
    if (YES == [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
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
    
    NSMutableDictionary *args = [[NSMutableDictionary alloc] init];
    [args setObject:@"This is a test image" forKey:@"message"];
    [args setObject:savedImage forKey:@"image"];
    [facebook requestWithGraphPath:@"me/photos" 
                         andParams:args 
                     andHttpMethod:@"POST"
                       andDelegate:self];
    [args release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker 
{
}

#pragma mark -
#pragma mark FBRequestDelegate

- (void)requestLoading:(FBRequest *)request {
	NSLog(@"requestLoading:");
}

/**
 * Called when the server responds and begins to send back data.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"didReceiveResponse:");
}

/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError:");
}

/**
 * Called when a request returns and its response has been parsed into an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number, depending
 * on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
	NSLog(@"didLoad:");
}

/**
 * Called when a request returns a response.
 *
 * The result object is the raw response from the server of type NSData
 */
- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data {
	NSLog(@"didLoadRawResponse:");
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
