//
//  ParsePerformanceTests.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 16.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Parse/Parse.h>

@interface ParsePerformanceTests : XCTestCase

//@property XCTestExpectation *expectation;
@property BOOL stop;

@end

static NSString* applicationKey = @"jJoI8tp07slznNEdWKX6qK2Pf2dXWvLcqjDb09hv";
static NSString* clientKey = @"tt4tGs7mlMYK4g099i7yd8pDMEANXMt9qNbqT57C";

@implementation ParsePerformanceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    [Parse setApplicationId:applicationKey clientKey:clientKey];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

//- (void) testOneRequest {
//    XCTestExpectation *expectation = [self expectationWithDescription:@"OneRequest"];
//    
//    [self measureBlock:^{
//        PFQuery *query = [PFQuery queryWithClassName:@"Place"];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            [expectation fulfill];
//        }];
//    }];
//    
//    [self waitForExpectationsWithTimeout:20 handler:^(NSError *error) {
//        if(error)NSLog(@"%@",error);
//    }];
//}

//- (void) testHundredRequest {
//    XCTestExpectation *expectation = [self expectationWithDescription:@"HundredRequests"];
//    __block NSInteger count = 0;
//    
//    
//    [self measureBlock:^{
//        for (NSInteger i = 0; i < 100; i++) {
//            PFQuery *query = [PFQuery queryWithClassName:@"Place"];
//            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                count++;
//                if (count == 100) [expectation fulfill];
//            }];
//        }
//    }];
//    
//    [self waitForExpectationsWithTimeout:20 handler:^(NSError *error) {
//        if(error)NSLog(@"%@",error);
//    }];
//}

//- (void) testForTenSeconds {
//    _stop = NO;
//    NSDate *start = [NSDate date];
//    __block NSTimeInterval executionTime;
//    __block NSInteger count = 0;
//    
//    [self measureBlock:^{
//        while (true) {
//            count++;
//            NSDate *methodFinish = [NSDate date];
//            executionTime = [methodFinish timeIntervalSinceDate:start];
//            if (executionTime > 10) break;
//            PFQuery *query = [PFQuery queryWithClassName:@"Place"];
//            [query findObjectsInBackground];
//        }
//    }];
//    
//    NSLog(@"requests: %lu", count);
//}

@end
