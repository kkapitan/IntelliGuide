//
//  GalleryCollectionViewCellTests.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 17.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCollectionViewCell.h"
#import <XCTest/XCTest.h>

@interface GalleryCollectionViewCellTests : XCTestCase

@end

@implementation GalleryCollectionViewCellTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDisplayingInformation{
    GalleryCollectionViewCell *GCVCell = [[GalleryCollectionViewCell alloc] init];
    UIImageView *imView = [[UIImageView alloc] init];
    [GCVCell setValue:imView forKey:@"galleryPhotoImageView"];
    GCVCell.galleryImage = [UIImage imageNamed:@"icon_x"];
    XCTAssertNotNil(imView.image);
    

}
@end
