//
//  AppDelegate.h
//  OAuthFacebook
//
//  Created by Christopher White on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@class LocationController;

extern Facebook	*facebook;
extern LocationController *locationController;

@class MainViewController;
@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	MainViewController	*mainViewController;
}

@end

