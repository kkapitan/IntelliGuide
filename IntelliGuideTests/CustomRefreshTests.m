//
//  CustomRefreshTests.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CustomRefresh.h"
#import "AttractionsTableViewController.h"

@interface CustomRefreshTests : XCTestCase <CustomRefreshProtocol>
@property CustomRefresh *customRefresh;
@property XCTestExpectation *delegateResponse;
@end

@implementation CustomRefreshTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAnimation {
    self.delegateResponse = [self expectationWithDescription:@"Delegate responds"];
    NSArray *customRefreshViewNib = [[NSBundle mainBundle] loadNibNamed:@"RefreshContents" owner:[AttractionsTableViewController class] options:nil];
    self.customRefresh = [customRefreshViewNib firstObject];
    self.customRefresh.delegate = self;
    [self.customRefresh animate];
    XCTAssertTrue(self.customRefresh.isAnimating);
    //while(self.customRefresh.isAnimating);
    // This is an example of a functional test case.
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if(error)NSLog(@"%@",error);
    }];
    
}

-(void)didEndRefreshing{
    XCTAssertFalse(self.customRefresh.isAnimating);
    [self.delegateResponse fulfill];
}


@end
