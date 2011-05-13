//
//  NSMutableArray+QueueAdditions.h
//  ApiFacebook
//
//  Created by Christopher White on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (QueueAdditions)
- (id) dequeue;
- (void) enqueue:(id)obj;
@end

