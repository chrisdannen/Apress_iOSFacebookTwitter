//
//  FriendTableViewCell.h
//  OAuthFacebook
//
//  Created by Christopher White on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@interface FriendTableViewCell : UITableViewCell <FBRequestDelegate> {
	NSDictionary *data;
    NSString *requestPath;
}

@property(nonatomic, retain) NSDictionary *data;
@property(nonatomic, retain) NSString *requestPath;

@end
