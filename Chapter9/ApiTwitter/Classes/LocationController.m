//
//  LocationController.m
//  ApiFacebook
//
//  Created by Christopher White on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationController.h"
#import "FTLocationSimulator.h"

@implementation LocationController

@synthesize locationManager;
@synthesize location;
@synthesize heading;

- (void)startWithPowerSaving:(BOOL)savingPower
{
    [self stop];
    
    if (nil == self.locationManager) {
#ifdef FAKE_CORE_LOCATION
        self.locationManager = [[[FTLocationSimulator alloc] init] autorelease];
#else
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
#endif
    }
    
    self.locationManager.delegate = self;
    
    //Available in 3.2 and later
    self.locationManager.purpose = @"Big brother is watching.";
    
    //as of 4.2, you can also check self.locationManager.authorizationStatus

    BOOL locationServicesEnabled = NO;
    if ([CLLocationManager respondsToSelector:@selector(locationServicesEnabled)]) {
        locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    } else {
        locationServicesEnabled = self.locationManager.locationServicesEnabled;
    }

    if (locationServicesEnabled) {
        
        inPowerSavingMode = NO;
        if (savingPower 
            && [CLLocationManager respondsToSelector:@selector(significantLocationChangeMonitoringAvailable)]) {
            if ([self.locationManager respondsToSelector:@selector(startMonitoringSignificantLocationChanges)]) {
                [self.locationManager startMonitoringSignificantLocationChanges];
                inPowerSavingMode = YES;
            }
            
        } else {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.locationManager.distanceFilter = kCLDistanceFilterNone;
            [self.locationManager startUpdatingLocation];
        }
    }
}

- (void)stop
{
    if (inPowerSavingMode 
        && [CLLocationManager respondsToSelector:@selector(significantLocationChangeMonitoringAvailable)]) {
        if ([self.locationManager respondsToSelector:@selector(stopMonitoringSignificantLocationChanges)]) {
            [self.locationManager stopMonitoringSignificantLocationChanges];
        }
    } else {
        [self.locationManager stopUpdatingLocation];
    }
}

- (BOOL)registerRegion:(CLLocationCoordinate2D)center
{
    // Check to see if support is available
    if (![CLLocationManager regionMonitoringAvailable] ||
        ![CLLocationManager regionMonitoringEnabled] )
        return NO;

    CLLocationDegrees radius = self.locationManager.maximumRegionMonitoringDistance;
    
    // Create the region and start monitoring it.
    CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:center
                                                               radius:radius 
                                                           identifier:@"test"];
    [self.locationManager startMonitoringForRegion:region 
                                   desiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    
    [region release];
    
    return YES;
    
}

- (void)dealloc
{
    [self stop];
    [locationManager release];
    [super dealloc];
}

#pragma mark CLLocationManagerDelegate

/*
 *  locationManager:didUpdateToLocation:fromLocation:
 *  
 *  Discussion:
 *    Invoked when a new location is available. oldLocation may be nil if there is no previous location
 *    available.
 */
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.location = newLocation;
}

/*
 *  locationManager:didUpdateHeading:
 *  
 *  Discussion:
 *    Invoked when a new heading is available.
 */
- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading  
{
    self.heading = newHeading;
}

/*
 *  locationManager:shouldDisplayHeadingCalibrationForDuration:
 *
 *  Discussion:
 *    Invoked when a new heading is available. Return YES to display heading calibration info. The display 
 *    will remain until heading is calibrated, unless dismissed early via dismissHeadingCalibrationDisplay.
 */
- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager 
{
    return YES;
}

/*
 *  locationManager:didFailWithError:
 *  
 *  Discussion:
 *    Invoked when an error has occurred. Error types are defined in "CLError.h".
 */
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error 
{
    NSLog(@"didFailWithError");
}

/*
 *  locationManager:didEnterRegion:
 *
 *  Discussion:
 *    Invoked when the user enters a monitored region.  This callback will be invoked for every allocated
 *    CLLocationManager instance with a non-nil delegate that implements this method.
 */
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region /* __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_0)*/ 
{
    NSLog(@"didEnterRegion");
}

/*
 *  locationManager:didExitRegion:
 *
 *  Discussion:
 *    Invoked when the user exits a monitored region.  This callback will be invoked for every allocated
 *    CLLocationManager instance with a non-nil delegate that implements this method.
 */
- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region /* __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_0) */
{
    NSLog(@"didExitRegion");
}

/*
 *  locationManager:monitoringDidFailForRegion:withError:
 *  
 *  Discussion:
 *    Invoked when a region monitoring error has occurred. Error types are defined in "CLError.h".
 */
- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error /* __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_0)  */
{
    NSLog(@"monitoringDidFailForRegion");
}

/*
 *  locationManager:didChangeAuthorizationStatus:
 *  
 *  Discussion:
 *    Invoked when the authorization status changes for this application.
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status /* __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_2) */
{
    NSLog(@"didChangeAuthorizationStatus");
}

@end
