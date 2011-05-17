//
//  FriendTableViewCell.m
//  OAuthFacebook
//
//  Created by Christopher White on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendTableViewCell.h"
#import "AppDelegate.h"
#import "FacebookRequestController.h"

@implementation FriendTableViewCell

@synthesize data;
@synthesize requestPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)facebookRequestDidComplete:(NSNotification*)notification {
    
    if (YES == [self.requestPath isEqualToString:[notification.userInfo objectForKey:@"path"]]) {
        
        UIImage *image = [UIImage imageWithData:(NSData*)[notification.userInfo objectForKey:@"result"]];
        self.imageView.image = image;
        [self setNeedsLayout];
    }
}

- (void)setData:(NSDictionary *)dictionary {
	[data release];
	data = [dictionary retain];

	self.textLabel.text = [data objectForKey:@"name"];
    
    self.imageView.image = nil;
	[self setNeedsLayout];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.requestPath = [NSString stringWithFormat:@"%@/picture", [data objectForKey:@"id"]];
    [[FacebookRequestController sharedRequestController] enqueueRequestWithGraphPath:self.requestPath];
    
    //listen for a notification with the name of the identifier
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(facebookRequestDidComplete:) 
												 name:kRequestCompletedNotification 
											   object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
	[data release];
    [requestPath release];
    [super dealloc];
}


@end
