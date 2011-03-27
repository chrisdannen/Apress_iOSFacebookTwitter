//
//  LoginViewController.h
//  OAuthFacebook
//
//  Created by Christopher White on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@class FBLoginButton;
@interface LoginViewController : UIViewController <FBSessionDelegate> {
	FBLoginButton *fbLoginButton;
}

@end
