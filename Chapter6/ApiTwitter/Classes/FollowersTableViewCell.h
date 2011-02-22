//
//  FollowersTableViewCell.h
//  ApiTwitter
//
//  Created by Christopher White on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowersTableViewCell : UITableViewCell {
	NSDictionary *data;
}

@property(nonatomic, retain) NSDictionary *data;

@end
