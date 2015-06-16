//
//  CategorySwitcherTableCellTests.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 17.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGCategory.h"
#import "CategorySwitcherTableCell.h"
#import <XCTest/XCTest.h>

@interface CategorySwitcherTableCellTests : XCTestCase

@end

@implementation CategorySwitcherTableCellTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDisplayingInformation{
    CategorySwitcherTableCell *CSTCell = [[CategorySwitcherTableCell alloc] init];
    
    UIImageView *imView = [[UIImageView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    [CSTCell setValue:label forKey:@"categoryLabel"];
    [CSTCell setValue:imView forKey:@"categoryImage"];

    IGCategory *category = [[IGCategory alloc] init];
    [category setValue:[UIImage imageNamed:@"icon_x"] forKey:@"image"];
    category.name =@"Test";
    
    
    CSTCell.category = category;
    
    XCTAssertEqual(@"Test",label.text);
    XCTAssertNotNil(imView);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self testDisplayingInformation];
    }];
}


@end
