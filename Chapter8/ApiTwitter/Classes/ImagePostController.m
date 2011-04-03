//
//  ImagePostController.m
//  ApiFacebook
//
//  Created by Christopher White on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImagePostController.h"
#import "TwitterLoginButton.h"
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

    twitterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	twitterButton.frame = CGRectMake(127.0f, 68.0f, 72.0f, 37.0f);
	[twitterButton setTitle:@"Twitter" forState:UIControlStateNormal];
	[twitterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[twitterButton addTarget:self action:@selector(twitterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:twitterButton];
    
    twitpicEngine = [(GSTwitPicEngine *)[GSTwitPicEngine twitpicEngineWithDelegate:self] retain];
    //cwnote: have to set this token from twitter
    [twitpicEngine setAccessToken:[sa_OAuthTwitterEngine accessToken]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [twitpicEngine release];
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
    
    [twitpicEngine uploadPicture:savedImage  withMessage:@"Hello world!"]; // This message is supplied back in success delegate call in request's userInfo.    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker 
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - GSTwitPicEngineDelegate

- (void)twitpicDidFinishUpload:(NSDictionary *)response 
{
    NSLog(@"TwitPic finished uploading: %@", response);
    
    // [response objectForKey:@"parsedResponse"] gives an NSDictionary of the response one of the parsing libraries was available.
    // Otherwise, use [[response objectForKey:@"request"] objectForKey:@"responseString"] to parse yourself.
    
    if ([[[response objectForKey:@"request"] userInfo] objectForKey:@"message"] > 0 && [[response objectForKey:@"parsedResponse"] count] > 0) {
        // Uncomment to update status upon successful upload, using MGTwitterEngine's instance.
        //NSString *update = [NSString stringWithFormat:@"%@ %@", [[[response objectForKey:@"request"] userInfo] objectForKey:@"message"], [[response objectForKey:@"parsedResponse"] objectForKey:@"url"]];
        NSString *update = [NSString stringWithFormat:@"%@ %@", [[response objectForKey:@"parsedResponse"] objectForKey:@"text"], [[response objectForKey:@"parsedResponse"] objectForKey:@"url"]];
        [sa_OAuthTwitterEngine sendUpdate:update];
    }
}

- (void)twitpicDidFailUpload:(NSDictionary *)error 
{
    NSLog(@"TwitPic failed to upload: %@", error);
    
    if ([[error objectForKey:@"request"] responseStatusCode] == 401) {
        //UIAlertViewQuick(@"Authentication failed", [error objectForKey:@"errorDescription"], @"OK");
    }
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
