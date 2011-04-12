//
//  LocationController.h
//  ApiFacebook
//
//  Created by Christopher White on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#ifdef FAKE_CORE_LOCATION
@class FTLocationSimulator;
#endif
@interface LocationController : NSObject <CLLocationManagerDelegate> {
#ifdef FAKE_CORE_LOCATION
	FTLocationSimulator *locationManager;
#else
    CLLocationManager *locationManager;
#endif
    CLLocation *location;
    CLHeading *heading;
    BOOL inPowerSavingMode;
}

#ifdef FAKE_CORE_LOCATION
@property(nonatomic, retain)FTLocationSimulator *locationManager;
#else
@property(nonatomic, retain)CLLocationManager *locationManager;
#endif
@property(nonatomic, retain)CLLocation *location;
@property(nonatomic, retain)CLHeading *heading;

- (void)startWithPowerSaving:(BOOL)savingPower;
- (void)stop;
- (BOOL)registerRegion:(CLLocationCoordinate2D)center;

@end
