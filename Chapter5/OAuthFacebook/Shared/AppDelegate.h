//
//  AppDelegate.h
//  OAuthFacebook
//
//  Created by Christopher White on 1/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

extern Facebook	*facebook;

@class FacebookViewController;
@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	FacebookViewController	*facebookViewController;
}

@end

