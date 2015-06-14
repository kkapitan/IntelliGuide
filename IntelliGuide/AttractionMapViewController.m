//
//  AttractionMapViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 13.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "AttractionMapViewController.h"
#import "IGAttraction.h"
#import "AttractionDetailsViewController.h"

@interface AttractionMapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property IGAttraction *destinationAttraction;
@end

@implementation AttractionMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
    [self addAnnotationsForAttractions:_attractions];
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addAnnotationsForAttractions:(NSArray*)attractions {
    for (PFObject *attraction in [self.attractions reverseObjectEnumerator]) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        IGAttraction *igattraction = [IGAttraction attractionWithParseObject:attraction];
        annotation.coordinate = igattraction.location.coordinate;
        annotation.title = igattraction.name;
        [self.mapView addAnnotation:annotation];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
    pin.pinColor = MKPinAnnotationColorPurple;
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MKPointAnnotation *a = (MKPointAnnotation*)view.annotation;
    NSInteger i = [self.attractions indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        PFObject *o = (PFObject*)obj;
        return o[[IGAttraction stringForKey:IGAttractionKeyName]] == a.title;
    }];
    self.destinationAttraction = [IGAttraction attractionWithParseObject:[self.attractions objectAtIndex:i]];
    
    [self performSegueWithIdentifier:@"FromMapToDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FromMapToDetails"]) {
        AttractionDetailsViewController *destVC = segue.destinationViewController;
        destVC.attraction = self.destinationAttraction;
    }
}

@end
