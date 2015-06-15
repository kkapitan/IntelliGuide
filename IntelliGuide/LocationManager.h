//
//  LocationManager.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 31.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/*!
 This protocol is used to notify delegate when geocoder has finished
 it's work and has found CLLocation for provided address
 */
@protocol FindCityProtocol <NSObject>

/*!
 This method is called when geocoder is ready to provide location
 
 @param location CCLocation found by geocoder
 
 @return void
 */
- (void) didObtainCityLocation:(CLLocation*)location;

@end

/*!
 This protocol is used to notify delegate when reverse geocoder has
 finished it's work and has found address for provided CLLocation
 */
@protocol FindLocationAddressProtocol <NSObject>

/*!
 This method is called when reverese geocoder is ready to provide address
 
 @param placemark CLPlacemark with all address info about provided CLLocation
 
 @return void
 */
- (void) didObtainLocationAddress:(CLPlacemark*)placemark;

@end

/*!
 LocationManager is responsible for managing location tasks and
 getting current user's position. It also provides methods to manually
 find location/address of given address/location.
 */
@interface LocationManager : NSObject <CLLocationManagerDelegate>

///------
///@name Fields
///------

/*!
 Property holding FindCityProtocol delegate that gets notified after fidning location
 */
@property (nonatomic) id<FindCityProtocol> locationDelegate;

/*!
 Property holding FindLocationAddressProtocol delegate that gets notified after fidning address
 */
@property (nonatomic) id<FindLocationAddressProtocol> addressDelegate;

/*!
 Property holding last location obtained by LocationManager. It is the most current
 location of device.
 */
@property (readonly) CLLocation *lastLocation;

///------
///@name Methods
///-----

/*!
 Returns singleton instance of LocationManager object
 
 @return object of type LocationManger, guaranteed to be singleton
 */
+ (id) sharedManager;

/*!
 This method uses geocoder to create CLLocation containing passed
 address coordinates. After it succeeds it calls delegate with found
 location as parameter.
 
 @param name NSString with address of which location you want to obtain.
 There is no strict format in which address can be,
 just provide as much details as you can.
 
 @return void
 */
- (void) getLocationFromCityName:(NSString*)name;

/*!
 This method uses reverse geocoder to get address from provided CLLocation
 
 @param location CCLocation which we want to transform into address
 
 @return void
 */
- (void) getAddressFromLocation:(CLLocation*)location;

/*!
 Setter for locationDelegate property
 
 @param locationDelegate Object that conforms to FindCityProtocol and
 wants to be notified after successful fetch of CLLocation from provided
 address
 
 @return void
 */
- (void) setLocationDelegate:(id<FindCityProtocol>)locationDelegate;

/*!
 Setter for addressDelegate property
 
 @param addressDelegate Object that conforms to FindLocationAddressProtocol
 and wants to be notified after successful fetch of CLLocation from provided
 address
 
 @return void
 */
- (void) setAddressDelegate:(id<FindLocationAddressProtocol>)addressDelegate;

@end
