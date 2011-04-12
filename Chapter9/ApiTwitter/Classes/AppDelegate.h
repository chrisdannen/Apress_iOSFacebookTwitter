//
//  AppDelegate.h
//  ApiTwitter
//
//  Created by Christopher White on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterEngine.h"

@class LocationController;

extern SA_OAuthTwitterEngine	*sa_OAuthTwitterEngine;
extern LocationController *locationController;

@class MainViewController;
@interface AppDelegate : NSObject <UIApplicationDelegate, SA_OAuthTwitterEngineDelegate> {
    UIWindow *window;
	MainViewController *mainViewController;
}

@end

