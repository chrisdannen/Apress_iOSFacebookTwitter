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
#import "SBJSON.h"

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

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //reverse geocode it's location and add it to your checkins
    MKReverseGeocoder *reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:view.annotation.coordinate];
    reverseGeocoder.delegate = self;
    [reverseGeocoder start];
    
    NSString *centerString = [NSString stringWithFormat: @"%f,%f", view.annotation.coordinate.latitude, view.annotation.coordinate.longitude];

	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"place",@"type",
								   centerString,@"center",
								   @"1000",@"distance", // In Meters (1000m = 0.62mi)
								   nil];
    
	[facebook requestWithGraphPath:@"search" andParams:params andDelegate:self];
}

#pragma mark -
#pragma mark MKReverseGeocoderDelegate

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    [geocoder release];
    
    NSString *cityState = [NSString stringWithFormat:@"%@,%@", placemark.locality, placemark.administrativeArea];
    NSLog(@"didFindPlacemark: %@", cityState);
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
}

#pragma mark -
#pragma mark FBRequestDelegate

- (void)requestLoading:(FBRequest *)request {
	NSLog(@"requestLoading:");
}

/**
 * Called when the server responds and begins to send back data.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"didReceiveResponse:");
}

/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError:");
}

/**
 * Called when a request returns and its response has been parsed into an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number, depending
 * on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
	NSLog(@"didLoad:");
    
    NSArray *places = [(NSDictionary*)result objectForKey:@"data"];
    if (0 < [places count]) {
        NSDictionary *dictionary = [places objectAtIndex:0];
        if (nil != dictionary) {
            NSDictionary *locationDictionary = [dictionary objectForKey:@"location"];
            
            NSMutableDictionary *coordinatesDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                          [locationDictionary objectForKey:@"latitude"], @"latitude",
                                                          [locationDictionary objectForKey:@"longitude"], @"longitude",
                                                          nil];
        
            SBJSON *jsonWriter = [[SBJSON new] autorelease];
            NSString *coordinates = [jsonWriter stringWithObject:coordinatesDictionary];
    
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           [dictionary objectForKey:@"id"], @"place", //The PlaceID
                                           coordinates, @"coordinates", // The latitude and longitude in string format (JSON)
                                           @"This is a test checkin", @"message", // The status message
                                           nil];
            
            [facebook requestWithGraphPath:@"me/checkins" andParams:params andHttpMethod:@"POST" andDelegate:self];
        }
    }
}

/**
 * Called when a request returns a response.
 *
 * The result object is the raw response from the server of type NSData
 */
- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data {
	NSLog(@"didLoadRawResponse:");
}


@end
