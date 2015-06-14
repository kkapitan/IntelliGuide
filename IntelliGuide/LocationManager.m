//
//  LocationManager.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 31.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

- (instancetype) init {
    self = [super init];
    
    if (self) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.headingFilter = kCLHeadingFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [self.locationManager requestWhenInUseAuthorization];
        
        [self.locationManager startUpdatingLocation];
    }
    
    return self;
}

+ (id) sharedManager {
    static LocationManager *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[LocationManager alloc] init];
    });
    return sharedSingleton;
}

- (void) setLocationDelegate:(id<FindCityProtocol>)locationDelegate {
    _locationDelegate = locationDelegate;
}

- (void) setAddressDelegate:(id<FindLocationAddressProtocol>)addressDelegate {
    _addressDelegate = addressDelegate;
}

#pragma mark CLLocation delegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *lastLocation = [locations lastObject];
    _lastLocation = lastLocation;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DidUpdateLocations" object:self];
    
    //    NSLog(@"vertical: %f, horizontal: %f", lastLocation.verticalAccuracy, lastLocation.horizontalAccuracy);
}

- (void) getLocationFromCityName:(NSString *)name {
    CLGeocoder* gc = [[CLGeocoder alloc] init];
    [gc geocodeAddressString:name completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if ([placemarks count]>0)
        {
            // get the first one
            CLPlacemark* mark = (CLPlacemark*)[placemarks objectAtIndex:0];
            if ([self.locationDelegate respondsToSelector:@selector(didObtainCityLocation:)]) {
                [self.locationDelegate didObtainCityLocation:mark.location];
            }
        }
    }];
}

- (void) getAddressFromLocation:(CLLocation*)location {
    CLGeocoder* gc = [[CLGeocoder alloc] init];
    [gc reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        if ([self.addressDelegate respondsToSelector:@selector(didObtainLocationAddress:)]) {
            [self.addressDelegate didObtainLocationAddress:placemark];
        }
    }];
}

@end
