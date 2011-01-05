//
//  AppDelegate_iPhone.h
//  HelloFacebook
//
//  Created by Christopher White on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelloFacebookViewController;
@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	HelloFacebookViewController	*helloFacebookViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

