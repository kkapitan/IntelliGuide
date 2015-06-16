//
//  ReviewCellTests.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 17.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGReview.h"
#import "ReviewCell.h"
#import "ASStarRatingView.h"
#import <XCTest/XCTest.h>

@interface ReviewCellTests : XCTestCase

@end

@implementation ReviewCellTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDisplayingInformation{
    IGReview *review = [[IGReview alloc] init];
    review.content = @"Test";
    review.rating = @4;
    
    PFUser* user = [[PFUser alloc] init];
    user.username = @"Test2";
    
    review.reviewer = user;
    
    UILabel *labelU = [[UILabel alloc] init];
    UILabel *labelC = [[UILabel alloc] init];
    ASStarRatingView *SRView = [[ASStarRatingView alloc] init];
    
    ReviewCell *cell = [[ReviewCell alloc] init];
    [cell setValue:labelU forKey:@"reviewerName"];
    [cell setValue:labelC forKey:@"reviewContent"];
    [cell setValue:SRView forKey:@"starRatingView"];
    
    cell.review = review;
    
    XCTAssertEqual(labelU.text, @"Test2");
    XCTAssertEqual(labelC.text, @"Test");
    XCTAssertEqual(SRView.rating,4);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self testDisplayingInformation];
    }];
}



@end
