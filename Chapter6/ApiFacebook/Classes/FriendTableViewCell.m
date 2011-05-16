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

- (void)requestLoading:(FBRequest *)request {
	NSLog(@"requestLoading:");
}

/**
 * Called when the server responds and begins to send back data.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"didReceiveResponse:");
}

/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError:");
}

/**
 * Called when a request returns and its response has been parsed into an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number, depending
 * on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
	NSLog(@"didLoad:");
	
	UIImage *image = [UIImage imageWithData:(NSData*)result];
	self.imageView.image = image;
	[self setNeedsLayout];
}

/**
 * Called when a request returns a response.
 *
 * The result object is the raw response from the server of type NSData
 */
- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data {
	NSLog(@"didLoadRawResponse:");
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
