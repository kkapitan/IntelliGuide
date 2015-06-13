//
//  AttractionMapViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 13.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "AttractionMapViewController.h"
#import "IGAttraction.h"

@interface AttractionMapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSMutableArray *annotations;
@end

@implementation AttractionMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
    self.annotations = [[NSMutableArray alloc] initWithCapacity:_attractions.count];
    [self addAnnotationsForAttractions:_attractions];
    [self.mapView showAnnotations:_annotations animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addAnnotationsForAttractions:(NSArray*)attractions {
    for (PFObject *attraction in self.attractions) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        IGAttraction *igattraction = [IGAttraction attractionWithParseObject:attraction];
        annotation.coordinate = igattraction.location.coordinate;
        [_annotations addObject:annotation];
    }
    
    [self.mapView addAnnotations:_annotations];
}

@end
