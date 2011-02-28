//
//  DialogViewController.h
//  ApiFacebook
//
//  Created by Christopher White on 2/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@class FBLoginButton;
@interface DialogViewController : UIViewController <FBDialogDelegate> {
	FBLoginButton *fbLoginButton;
}

@end
