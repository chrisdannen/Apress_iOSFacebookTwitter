//
//  MapViewController.h
//  ApiFacebook
//
//  Created by Christopher White on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Facebook.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, MKReverseGeocoderDelegate, FBRequestDelegate> {
    
}

@end
