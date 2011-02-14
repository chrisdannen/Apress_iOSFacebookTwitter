//
//  MainViewController.h
//  HelloTwitter
//
//  Created by Christopher White on 1/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterController.h"

@class TwitterLoginButton;
@interface MainViewController : UIViewController <SA_OAuthTwitterControllerDelegate> {
	TwitterLoginButton *twitterLoginButton;
}

@end
