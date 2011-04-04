//
//  FollowersTableViewCell.h
//  ApiTwitter
//
//  Created by Christopher White on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tweet;
@interface TweetTableViewCell : UITableViewCell {
	Tweet *tweet;
}

@property(nonatomic, retain) Tweet *tweet;

@end
