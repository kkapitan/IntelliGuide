//
//  MapViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 06.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController() <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    self.mapView.scrollEnabled = NO;
    self.mapView.delegate = self;
    
    if (self.attraction.location != nil) {
        MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
        MKCoordinateRegion region = MKCoordinateRegionMake(self.attraction.location.coordinate, span);
        [self.mapView setRegion:region animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.attraction.location != nil) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:self.attraction.location.coordinate];
        
        [self.mapView addAnnotation:annotation];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
    pin.pinColor = MKPinAnnotationColorPurple;
    pin.animatesDrop = YES;
    return pin;
}

@end
