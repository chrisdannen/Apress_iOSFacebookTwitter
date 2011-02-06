//
//  AppDelegate.h
//  HelloTwitter
//
//  Created by Christopher White on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTwitterEngine.h"

extern MGTwitterEngine	*mgTwitterEngine;

@class MainViewController;
@interface AppDelegate : NSObject <UIApplicationDelegate, MGTwitterEngineDelegate> {
    UIWindow *window;
	MainViewController *mainViewController;
}

@end

