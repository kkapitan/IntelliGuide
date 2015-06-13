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

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property id<FindCityProtocol> delegate;
@property CLLocationManager *locationManager;
@property (readonly) CLLocation *lastLocation;

+ (id) sharedManager;
- (CLLocation*) getLocationFromCityName:(NSString*)name;
- (void) setFindCityDelegate:(id<FindCityProtocol>)delegate;

@end
