//
//  LocationManager.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 31.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol FindCityProtocol <NSObject>

- (void) didObtainCityLocation:(CLLocation*)location;

@end

@protocol FindLocationAddressProtocol <NSObject>

- (void) didObtainLocationAddress:(CLPlacemark*)placemark;

@end

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic) id<FindCityProtocol> locationDelegate;
@property (nonatomic) id<FindLocationAddressProtocol> addressDelegate;
@property CLLocationManager *locationManager;
@property (readonly) CLLocation *lastLocation;

+ (id) sharedManager;
- (void) getLocationFromCityName:(NSString*)name;
- (void) getAddressFromLocation:(CLLocation*)location;
- (void) setLocationDelegate:(id<FindCityProtocol>)locationDelegate;
- (void) setAddressDelegate:(id<FindLocationAddressProtocol>)addressDelegate;

@end
