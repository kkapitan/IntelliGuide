//
//  AttractionCellTests.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 17.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IGAttraction.h"
#import "AttractionCell.h"

@interface AttractionCellTests : XCTestCase

@end

@implementation AttractionCellTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDisplayingInformation{
    
    IGAttraction *attraction = [[IGAttraction alloc] init];
    attraction.name = @"Test";
    IGCategory *category = [[IGCategory alloc] init];
    [category setValue:[UIImage imageNamed:@"icon_x"] forKey:@"image"];
    attraction.category = category;
    
    AttractionCell *attractionCell = [[AttractionCell alloc] init];
    
    UILabel *label = [[UILabel alloc] init];
    UIImageView *imView = [[UIImageView alloc ] init];
   [attractionCell setValue:imView forKey:@"categoryIcon"];
   [attractionCell setValue:label forKey:@"name"];
    
    attractionCell.attraction = attraction;
    
    XCTAssertEqual(label.text,@"Test");
    XCTAssertNotNil(imView.image);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self testDisplayingInformation];
    }];
}


@end
