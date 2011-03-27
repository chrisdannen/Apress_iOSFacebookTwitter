//
//  ImagePostController.h
//  ApiFacebook
//
//  Created by Christopher White on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePostController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    UIButton *twitterButton;
    UIImage *savedImage;
}

@end
