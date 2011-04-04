//
//  OfflineTwitterAppDelegate.h
//  OfflineTwitter
//
//  Created by Christopher White on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterEngine.h"

extern SA_OAuthTwitterEngine	*sa_OAuthTwitterEngine;

@class MainViewController;
@interface OfflineTwitterAppDelegate : NSObject <UIApplicationDelegate, SA_OAuthTwitterEngineDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

