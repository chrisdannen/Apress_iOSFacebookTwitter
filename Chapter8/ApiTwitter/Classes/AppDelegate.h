//
//  AppDelegate.h
//  ApiTwitter
//
//  Created by Christopher White on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterEngine.h"

extern SA_OAuthTwitterEngine	*sa_OAuthTwitterEngine;

@class MainViewController;
@interface AppDelegate : NSObject <UIApplicationDelegate, SA_OAuthTwitterEngineDelegate> {
    UIWindow *window;
	MainViewController *mainViewController;
}

@end

