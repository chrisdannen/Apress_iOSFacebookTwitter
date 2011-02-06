//
//  AppDelegate.h
//  HelloFacebook
//
//  Created by Christopher White on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

extern Facebook	*facebook;

@class HelloFacebookViewController;
@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	HelloFacebookViewController	*helloFacebookViewController;
}

@end

