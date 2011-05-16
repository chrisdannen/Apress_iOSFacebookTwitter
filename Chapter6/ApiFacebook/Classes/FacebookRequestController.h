//
//  FacebookRequestController.h
//  ApiFacebook
//
//  Created by Christopher White on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"

extern NSString * const kRequestCompletedNotification;

@interface FacebookRequestController : NSObject <FBRequestDelegate> {
    NSDictionary *currentRequestDictionary;
    NSMutableArray *requestQueue;
}

@property(nonatomic, retain) NSDictionary *currentRequestDictionary;

+ (FacebookRequestController*)sharedRequestController;
- (void)enqueueRequestWithGraphPath:(NSString*)path;

@end
