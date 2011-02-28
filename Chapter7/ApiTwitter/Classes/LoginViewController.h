//
//  LoginViewController.h
//  ApiTwitter
//
//  Created by Christopher White on 2/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterController.h"

@class TwitterLoginButton;
@interface LoginViewController : UIViewController <SA_OAuthTwitterControllerDelegate> {
	TwitterLoginButton *twitterLoginButton;
}

@end
