//
//  TwitterDataStore_SQLite.h
//  OfflineTwitter
//
//  Created by Christopher White on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterDataStore.h"

@class sqlite3;
@interface TwitterDataStore_SQLite : TwitterDataStore {
    sqlite3		*database;
}

@end
