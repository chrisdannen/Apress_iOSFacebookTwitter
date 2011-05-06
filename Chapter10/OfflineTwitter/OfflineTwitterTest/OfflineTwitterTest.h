//
//  OfflineTwitterTest.h
//  OfflineTwitterTest
//
//  Created by Christopher White on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class TwitterDataStore_SQLite;
@interface OfflineTwitterTest : SenTestCase {
@private
    TwitterDataStore_SQLite *twitterDataStore;
}

@end
