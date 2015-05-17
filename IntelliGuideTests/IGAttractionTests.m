//
//  IGAttractionTests.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 17.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IGAttraction.h"
#import <OCMock/OCMock.h>

@interface IGAttractionTests : XCTestCase

@end

@implementation IGAttractionTests {
    id mockParseObject;
    id mockPFUser;
    id mockPFFile;
    id mockCategoryParseFile;
    
    IGAttraction *attraction;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    mockParseObject = OCMClassMock([PFObject class]);
    mockPFUser = OCMClassMock([PFUser class]);
    mockPFFile = OCMClassMock([PFFile class]);
    mockCategoryParseFile = OCMClassMock([PFObject class]);
    
    PFObject *categoryObject = [PFObject objectWithClassName:@"Category"];
    categoryObject[@"name"] = @"Park";
    categoryObject.objectId = @"abc123";
    
    OCMStub([mockParseObject objectId]).andReturn(@"abc123");
    OCMStub(mockParseObject[[IGAttraction stringForKey:IGAttractionKeyName]]).andReturn(@"Park Wilsona");
    OCMStub(mockParseObject[[IGAttraction stringForKey:IGAttractionKeyDescription]]).andReturn(@"Malowniczy park położony w pięknej dolinie");
    OCMStub(mockParseObject[[IGAttraction stringForKey:IGAttractionKeyVerified]]).andReturn(@"true");
    OCMStub(mockParseObject[[IGAttraction stringForKey:IGAttractionKeyImage]]).andReturn(mockPFFile);
    OCMStub(mockPFUser[@"username"]).andReturn(@"Pani Krysia");
    OCMStub(mockParseObject[[IGAttraction stringForKey:IGAttractionKeyCreator]]).andReturn(mockPFUser);
//    OCMStub(mockCategoryParseFile[[IGCategory stringForKey:IGCategoryKeyName]]).andReturn(@"Park");
    OCMStub(mockParseObject[[IGAttraction stringForKey:IGAttractionKeyCategory]]).andReturn(categoryObject);
    
    attraction = [IGAttraction attractionWithParseObject:mockParseObject];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testStringForKey {
    //given
    NSInteger categoryKey1 = IGAttractionKeyName;
    NSInteger categoryKey2 = IGAttractionKeyCreator;
    NSInteger categoryKey3 = IGAttractionKeyDescription;
    NSInteger categoryKey4 = IGAttractionKeyCategory;
    NSInteger categoryKey5 = IGAttractionKeyImage;
    NSInteger categoryKey6 = IGAttractionKeyVerified;
    NSInteger wrongCategoryKey = 69;
    
    //when
    NSString *stringForKey1 = [IGAttraction stringForKey:categoryKey1];
    NSString *stringForKey2 = [IGAttraction stringForKey:categoryKey2];
    NSString *stringForKey3 = [IGAttraction stringForKey:categoryKey3];
    NSString *stringForKey4 = [IGAttraction stringForKey:categoryKey4];
    NSString *stringForKey5 = [IGAttraction stringForKey:categoryKey5];
    NSString *stringForKey6 = [IGAttraction stringForKey:categoryKey6];
    NSString *wrongStringForKey;
    @try {
        wrongStringForKey = [IGAttraction stringForKey:wrongCategoryKey];
        XCTFail(@"Did not throw an exception");
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    //then
    XCTAssertEqualObjects(stringForKey1, @"name");
    XCTAssertEqualObjects(stringForKey2, @"creator");
    XCTAssertEqualObjects(stringForKey3, @"description");
    XCTAssertEqualObjects(stringForKey4, @"category");
    XCTAssertEqualObjects(stringForKey5, @"image");
    XCTAssertEqualObjects(stringForKey6, @"verified");
    
    XCTAssertNil(wrongStringForKey);
}

- (void)testCreatingObject {
    //when
    
    //then
    XCTAssertEqualObjects(attraction.objectId, @"abc123");
    XCTAssertEqualObjects(attraction.name, @"Park Wilsona");
    XCTAssertEqualObjects(attraction.placeDescription, @"Malowniczy park położony w pięknej dolinie");
    XCTAssertEqualObjects(attraction.creator[@"username"], @"Pani Krysia");
    XCTAssertEqualObjects(NSStringFromClass(attraction.imageFile.class), @"PFFile");
//    XCTAssertEqualObjects(NSStringFromClass(attraction.category.class), @"IGCategory");
}

- (void) testParseObject {
    PFObject *object = [PFObject objectWithClassName:@"Place"];
    object.objectId = @"abc123";
    object[[IGAttraction stringForKey:IGAttractionKeyName]] = @"Park Wilsona";
    object[[IGAttraction stringForKey:IGAttractionKeyDescription]] = @"Malowniczy park położony w pięknej dolinie";
    object[[IGAttraction stringForKey:IGAttractionKeyImage]] = mockPFFile;
    object[[IGAttraction stringForKey:IGAttractionKeyCreator]] = mockPFUser;
    
    
//    XCTAssert([NSStringFromClass([[attraction parseObject] class]) isEqualToString:@"PFObject"]);
    
    PFObject *returned = [attraction parseObject];
    
    XCTAssertEqualObjects(object.objectId, returned.objectId);
    XCTAssertEqualObjects(object[[IGAttraction stringForKey:IGAttractionKeyName]], returned[[IGAttraction stringForKey:IGAttractionKeyName]]);
    XCTAssertEqualObjects(object[[IGAttraction stringForKey:IGAttractionKeyDescription]], returned[[IGAttraction stringForKey:IGAttractionKeyDescription]]);
}

@end
