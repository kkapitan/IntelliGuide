//
//  GalleryFetcherTests.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GalleryFetcher.h"

@interface GalleryFetcherTests : XCTestCase
@property XCTestExpectation *expectation;
@end

@implementation GalleryFetcherTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    self.expectation = [self expectationWithDescription:@"DownloadGallery"];
    [GalleryFetcher fetchGalleryForPlaceWithId:@"hhdBdftA4c" completion:^(NSArray *images) {
        XCTAssertEqual(images.count, 5);
        [self.expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if(error)NSLog(@"%@",error);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self testExample];
    }];
}

@end
