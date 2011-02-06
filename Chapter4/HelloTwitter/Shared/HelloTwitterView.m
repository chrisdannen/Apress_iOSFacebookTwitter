//
//  HelloTwitterView.m
//  HelloTwitter
//
//  Created by Christopher White on 1/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelloTwitterView.h"
#import "AppDelegate.h"

@implementation HelloTwitterView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
		
		[mgTwitterEngine getPublicTimeline];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
