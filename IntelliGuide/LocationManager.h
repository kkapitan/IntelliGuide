//
//  LocationManager.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 31.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property (readonly) CLLocation *lastLocation;

+ (id) sharedManager;

@end
