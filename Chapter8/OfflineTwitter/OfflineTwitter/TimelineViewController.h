//
//  TimelineViewController.h
//  ApiTwitter
//
//  Created by Christopher White on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterDataStore;
@interface TimelineViewController : UITableViewController {
    NSArray             *tweets;
    TwitterDataStore    *twitterDataStore;
}

@end
