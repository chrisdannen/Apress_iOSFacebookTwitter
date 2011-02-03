//
//  HelloTwitterView.m
//  HelloTwitter
//
//  Created by Christopher White on 1/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelloTwitterView.h"
#import "AppDelegate.h"

static NSString* kConsumerKey = @"poop";
static NSString* kConsumerSecret = @"chalupa";

@implementation HelloTwitterView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
		
		mgTwitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self]; 
		
		[mgTwitterEngine setConsumerKey:kConsumerKey secret:kConsumerSecret];
		NSString *xauth = [mgTwitterEngine getXAuthAccessTokenForUsername:@"christhepiss" 
																 password:@"1033jB124!"];
		
		int i = 0;
		
		//[twitterEngine setUsername:@"username" password:@"password"]; 
		// Get updates from people the authenticated user follows. NSString *connectionID = [twitterEngine getFollowedTimelineFor:nil since:nil startingAtPage:0];
    }
    return self;
}

#pragma mark -
#pragma mark FBRequestDelegate

- (void)connectionStarted:(NSString *)connectionIdentifier {
	NSLog(@"connectionStarted");
}

- (void)connectionFinished:(NSString *)connectionIdentifier {
	NSLog(@"connectionFinished");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[mgTwitterEngine release];
    [super dealloc];
}


@end
