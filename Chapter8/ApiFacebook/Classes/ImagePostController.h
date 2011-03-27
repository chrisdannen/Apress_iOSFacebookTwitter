//
//  ImagePostController.h
//  ApiFacebook
//
//  Created by Christopher White on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@class FBLoginButton;
@interface ImagePostController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, FBRequestDelegate> {
    FBLoginButton *fbLoginButton;
    UIImage *savedImage;
}

@end
