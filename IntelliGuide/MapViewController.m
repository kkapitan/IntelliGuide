//
//  MapViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 06.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "LocationManager.h"

@interface MapViewController() <MKMapViewDelegate, FindLocationAddressProtocol>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    self.mapView.scrollEnabled = NO;
    self.mapView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapView removeAnnotations:self.mapView.annotations];
    if (self.attraction.location != nil) {
        MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
        MKCoordinateRegion region = MKCoordinateRegionMake(self.attraction.location.coordinate, span);
        [self.mapView setRegion:region animated:YES];
        [[LocationManager sharedManager] setAddressDelegate:self];
        [[LocationManager sharedManager] getAddressFromLocation:self.attraction.location];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
    pin.pinColor = MKPinAnnotationColorPurple;
    pin.canShowCallout = YES;
    pin.animatesDrop = YES;
    return pin;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    [mapView selectAnnotation:[[mapView annotations] lastObject] animated:YES];
}

- (void)didObtainLocationAddress:(CLPlacemark *)placemark {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:self.attraction.location.coordinate];
    if (placemark.thoroughfare != nil && placemark.subThoroughfare != nil) {
        annotation.title = [NSString stringWithFormat:@"%@ %@", placemark.thoroughfare, placemark.subThoroughfare];
    }
    [self.mapView addAnnotation:annotation];
}

@end
