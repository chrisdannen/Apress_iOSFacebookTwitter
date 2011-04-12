//
//  FollowersTableViewCell.m
//  ApiTwitter
//
//  Created by Christopher White on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FollowersTableViewCell.h"
#import "AppDelegate.h"

@implementation FollowersTableViewCell

@synthesize data;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)twitterProfileImageRequestDidComplete:(NSNotification*)notification {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	self.imageView.image = [notification.userInfo objectForKey:@"profile_image"];
	[self setNeedsLayout];
}

- (void)setData:(NSDictionary *)dictionary {
	[data release];
	data = [dictionary retain];

	self.textLabel.text = [data objectForKey:@"screen_name"];
	
	NSString *identifier = [sa_OAuthTwitterEngine getImageAtURL:[dictionary objectForKey:@"profile_image_url"]];
	
	//listen for a notification with the name of the identifier
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(twitterProfileImageRequestDidComplete:) 
												 name:identifier 
											   object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[data release];
    [super dealloc];
}


@end
