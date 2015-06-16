//
//  IGReviewTests.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 17.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IGReview.h"
#import <OCMock/OCMock.h>

@interface IGReviewTests : XCTestCase

@end

@implementation IGReviewTests {
    id mockParseObject;
    id mockPFUser;
    IGReview *review;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    mockParseObject = OCMClassMock([PFObject class]);
    mockPFUser = OCMClassMock([PFUser class]);
    
    OCMStub([mockParseObject objectId]).andReturn(@"abc123");
    OCMStub(mockParseObject[[IGReview stringForKey:IGReviewKeyContent]]).andReturn(@"Malowniczy park położony w pięknej dolinie");
    OCMStub(mockParseObject[[IGReview stringForKey:IGReviewKeyRating]]).andReturn(@4);
    OCMStub(mockPFUser[@"username"]).andReturn(@"Pani Krysia");
    OCMStub(mockParseObject[[IGReview stringForKey:IGReviewKeyReviewer]]).andReturn(mockPFUser);
    
    review = [IGReview reviewWithParseObject:mockParseObject];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreatingObject {
    //when
    
    //then
    XCTAssertEqualObjects(review.objectId, @"abc123");
    XCTAssertEqualObjects(review.content, @"Malowniczy park położony w pięknej dolinie");
    XCTAssertEqualObjects(review.rating, @4);
    XCTAssertEqualObjects(review.reviewer[@"username"], @"Pani Krysia");
}

- (void) testStringForKey {
    //given
    NSInteger categoryKey1 = IGReviewKeyRating;
    NSInteger categoryKey2 = IGReviewKeyContent;
    NSInteger categoryKey3 = IGReviewKeyReviewer;
    NSInteger wrongCategoryKey = 69;
    
    //when
    NSString *stringForKey1 = [IGReview stringForKey:categoryKey1];
    NSString *stringForKey2 = [IGReview stringForKey:categoryKey2];
    NSString *stringForKey3 = [IGReview stringForKey:categoryKey3];
    NSString *wrongStringForKey;
    @try {
        wrongStringForKey = [IGReview stringForKey:wrongCategoryKey];
        XCTFail(@"Did not throw an exception");
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    //then
    XCTAssertEqualObjects(stringForKey1, @"stars");
    XCTAssertEqualObjects(stringForKey2, @"content");
    XCTAssertEqualObjects(stringForKey3, @"writtenBy");
    
    XCTAssertNil(wrongStringForKey);
}

- (void) testParseObject {
    PFObject *object = [PFObject objectWithClassName:@"Review"];
    object[[IGReview stringForKey:IGReviewKeyRating]] = @4;
    object[[IGReview stringForKey:IGReviewKeyContent]] = @"Malowniczy park położony w pięknej dolinie";
    
    
    XCTAssert([NSStringFromClass([[review parseObject] class]) isEqualToString:@"PFObject"]);
    
    PFObject *returned = [review parseObject];
    
    XCTAssertEqualObjects(object[[IGReview stringForKey:IGReviewKeyReviewer]], returned[[IGReview stringForKey:IGReviewKeyReviewer]]);
    XCTAssertEqualObjects(object[[IGReview stringForKey:IGReviewKeyRating]], returned[[IGReview stringForKey:IGReviewKeyRating]]);
    XCTAssertEqualObjects(object[[IGReview stringForKey:IGReviewKeyContent]], returned[[IGReview stringForKey:IGReviewKeyContent]]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self testCreatingObject];
    }];
}

- (void)testPerformanceExample2 {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self testParseObject];
    }];
}

- (void)testPerformanceExample3 {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self testStringForKey];
    }];
}


@end
