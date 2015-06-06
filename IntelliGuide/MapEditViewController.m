//
//  MapEditViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 06.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "MapEditViewController.h"

@interface MapEditViewController() <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property CLLocation* currentLocation;
- (IBAction)doneTapped:(id)sender;
- (IBAction)mapTapped:(UITapGestureRecognizer *)sender;

@end

@implementation MapEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentLocation = _initialLocation;
    _mapView.delegate = self;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.currentLocation.coordinate, span);
    [self.mapView setRegion:region animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:self.currentLocation.coordinate];
    
    [self.mapView addAnnotation:annotation];
}

- (IBAction)doneTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectLocation:)]) {
        [self.delegate didSelectLocation:_currentLocation];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)mapTapped:(UITapGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    _currentLocation = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:touchMapCoordinate];
    
    [self.mapView addAnnotation:annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
    pin.pinColor = MKPinAnnotationColorPurple;
    pin.animatesDrop = YES;
    return pin;
}
@end
