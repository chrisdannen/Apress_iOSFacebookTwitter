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
		
		/*
		 NSDictionary *dictionary = (NSDictionary*)result;
		 
		 UILabel *label = [[UILabel alloc] initWithFrame:self.frame];
		 label.text = [dictionary description];
		 [self addSubview:label];
		 [label release];
		 */
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
