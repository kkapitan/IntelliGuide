//
//  LocationManagerTests.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 16.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LocationManager.h"

@interface LocationManagerTests : XCTestCase <FindLocationAddressProtocol, FindCityProtocol>

@property BOOL obtainedLocation;
@property BOOL obtainedAddress;
@property XCTestExpectation *expectation;

@end

@implementation LocationManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testSingleton {
    LocationManager *manager1 = [LocationManager sharedManager];
    LocationManager *manager2 = [LocationManager sharedManager];
    XCTAssertEqual(manager1, manager2);
}

- (void)didObtainCityLocation:(CLLocation *)location {
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:52.4 longitude:16.93];
    XCTAssertLessThan([loc distanceFromLocation:location], 5000.0);
    [self.expectation fulfill];
}

- (void) testLocationDelegate {
    _obtainedLocation = NO;
    self.expectation = [self expectationWithDescription:@"Location"];
    
    LocationManager *manager = [LocationManager sharedManager];
    [manager setLocationDelegate:self];
    [manager getLocationFromCityName:@"Poznań"];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if(error)NSLog(@"%@",error);
    }];
}

- (void)didObtainLocationAddress:(CLPlacemark *)placemark {
    XCTAssertEqualObjects(placemark.addressDictionary[@"City"], @"Poznan");
    [self.expectation fulfill];
}

- (void) testAddressDelegate {
    _obtainedAddress = NO;
    self.expectation = [self expectationWithDescription:@"Address"];
    
    LocationManager *manager = [LocationManager sharedManager];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:52.4 longitude:16.93];
    [manager setAddressDelegate:self];
    [manager getAddressFromLocation:location];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if(error)NSLog(@"%@",error);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
