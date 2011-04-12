//
//  MapViewController.m
//  ApiFacebook
//
//  Created by Christopher White on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "FTLocationSimulator.h"
#import "AppDelegate.h"
#import "LocationController.h"
#import "FTLocationSimulator.h"
#import <MapKit/MapKit.h>

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Map" image:nil tag:0] autorelease];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
    [super loadView];

     MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 411.0f)];
     mapView.delegate = self;
     mapView.showsUserLocation = YES;
     
#ifdef FAKE_CORE_LOCATION
     locationController.locationManager.mapView = mapView;
#endif

     [self.view addSubview:mapView];
     [mapView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 
#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"regionWillChangeAnimated");
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"regionDidChangeAnimated");
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    NSLog(@"mapViewWillStartLoadingMap");
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    NSLog(@"mapViewDidFinishLoadingMap");
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"mapViewDidFailLoadingMap");
}

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView
{
    NSLog(@"mapViewWillStartLocatingUser");
}

- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView
{
    NSLog(@"mapViewDidStopLocatingUser");
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"didFailToLocateUserWithError");
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    static int once = 0;
    if (0 == once) {
        once = 1;
        
        // create the pin annotation
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = userLocation.coordinate;
        [mapView addAnnotation:annotation];
        [annotation release];
        
        [locationController registerRegion:userLocation.coordinate];
    }
    
    NSLog(@"didUpdateUserLocation");
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isMemberOfClass:[MKUserLocation class]]) {
#ifdef FAKE_CORE_LOCATION
        //get the app delegate's location manager and return it's fake user location view
		return locationController.locationManager.fakeUserLocationView;
#else
		return nil;
#endif
	} else {
        if ([annotation isKindOfClass:[MKPointAnnotation class]])
            
        {
            // Try to dequeue an existing pin view first.
            MKPinAnnotationView*    pinView = (MKPinAnnotationView*)[mapView
                                                                     dequeueReusableAnnotationViewWithIdentifier:@"PinAnnotationView"];
            if (!pinView) {
                // If an existing pin view was not available, create one.
                pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:@"PinAnnotation"]
                           autorelease];
                pinView.pinColor = MKPinAnnotationColorRed;
                pinView.animatesDrop = YES;
            }
            else
                pinView.annotation = annotation;

            return pinView;
        }
    }
	// code to create views for other annotations
	return nil;
}

- (void)twitterPlacesRequestDidComplete:(NSNotification*)notification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
	NSArray *places = [notification.userInfo objectForKey:@"places"];
    if (0 < [places count]) {
        //grab the first place
        NSDictionary *placesDict = [places objectAtIndex:0];
        NSDictionary *resultDict = [placesDict objectForKey:@"result"];
        NSArray *resultPlaces = [resultDict objectForKey:@"places"];
        if (0 < [resultPlaces count]) {
            NSDictionary *firstPlace = [resultPlaces objectAtIndex:0];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:[firstPlace objectForKey:@"id"] forKey:@"place_id"];
            [sa_OAuthTwitterEngine sendUpdate:@"this is a location tweet!" withParams:params];
        }
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //uncomment this to experiment with the reverse geocoder in MapKit. See the associated MKReverseGeocoderDelegate method below
    /*
    //reverse geocode it's location and add it to your checkins
    MKReverseGeocoder *reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:view.annotation.coordinate];
    reverseGeocoder.delegate = self;
    [reverseGeocoder start];
     */

    NSNumber *lat = [NSNumber numberWithDouble:view.annotation.coordinate.latitude];
    NSNumber *lon = [NSNumber numberWithDouble:view.annotation.coordinate.longitude];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //[params setObject:@"London" forKey:@"query"];
    [params setObject:[lat stringValue] forKey:@"lat"];
    [params setObject:[lon stringValue] forKey:@"long"];
    //[sa_OAuthTwitterEngine geoResultsForPath:@"search" withParams:params];
    NSString *identifier = [sa_OAuthTwitterEngine geoResultsForPath:@"reverse_geocode" withParams:params];
    //[params setObject:@"Twitter HQ" forKey:@"name"];
    //[sa_OAuthTwitterEngine geoResultsForPath:@"similar_places" withParams:params];
    
    //listen for a notification with the name of the identifier
	[[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(twitterPlacesRequestDidComplete:) 
                                                 name:identifier 
                                               object:nil];
}

#pragma mark -
#pragma mark MKReverseGeocoderDelegate

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    [geocoder release];

    NSString *cityState = [NSString stringWithFormat:@"%@,%@", placemark.locality, placemark.administrativeArea];
    NSLog(@"didFindPlacemark: %@", cityState);

    /*
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:cityState forKey:@"query"];
    [params setObject:@"city" forKey:@"granularity"];
    NSString *identifier = [sa_OAuthTwitterEngine geoResultsForPath:@"search" withParams:params];
    
    //listen for a notification with the name of the identifier
	[[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(twitterPlacesRequestDidComplete:) 
                                                 name:identifier 
                                               object:nil];
     */
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
}


@end
