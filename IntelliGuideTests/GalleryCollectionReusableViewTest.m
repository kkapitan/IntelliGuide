//
//  GalleryCollectionReusableViewTest.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 17.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCollectionReusableView.h"
#import <XCTest/XCTest.h>

@interface GalleryCollectionReusableViewTest : XCTestCase

@end

@implementation GalleryCollectionReusableViewTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDisplayingInformation{
    GalleryCollectionReusableView *GCRView = [[GalleryCollectionReusableView alloc] init];
    UIImageView *imView = [[UIImageView alloc] init];
    [GCRView setValue:imView forKey:@"headerImageView"];
    GCRView.headerImage = [UIImage imageNamed:@"icon_x"];
    XCTAssertNotNil(imView.image);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self testDisplayingInformation];
    }];
}


@end
