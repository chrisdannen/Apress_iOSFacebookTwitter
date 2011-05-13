//
//  NSMutableArray+QueueAdditions.m
//  ApiFacebook
//
//  Created by Christopher White on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+QueueAdditions.h"


@implementation NSMutableArray (QueueAdditions)

- (id)dequeue 
{
    if ([self count] == 0) {
        return nil;
    }
    id queueObject = [[[self objectAtIndex:0] retain] autorelease];
    [self removeObjectAtIndex:0];
    return queueObject;
}


// Add to the tail of the queue (no one likes it when people cut in line!)
- (void) enqueue:(id)anObject 
{
    [self addObject:anObject];
    //this method automatically adds to the end of the array
}
@end

