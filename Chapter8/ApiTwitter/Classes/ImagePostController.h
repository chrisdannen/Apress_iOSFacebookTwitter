//
//  ImagePostController.h
//  ApiFacebook
//
//  Created by Christopher White on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSTwitPicEngine.h"

@interface ImagePostController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, GSTwitPicEngineDelegate> {
    UIButton *twitterButton;
    UIImage *savedImage;
    GSTwitPicEngine *twitpicEngine;
}

@end
