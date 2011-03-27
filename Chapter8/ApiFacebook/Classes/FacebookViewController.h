//
//  FacebookViewController.h
//  OAuthFacebook
//
//  Created by Christopher White on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@interface FacebookViewController : UITableViewController <FBRequestDelegate> {
	NSArray	*items;
}

@end
