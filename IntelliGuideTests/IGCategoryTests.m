//
//  IGCategoryTests.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 17.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IGCategory.h"
#import <OCMock/OCMock.h>

@interface IGCategoryTests : XCTestCase

@end

@implementation IGCategoryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreatingObject {
    //given
    id mockParseObject = [OCMockObject mockForClass:[PFObject class]];
    [[[mockParseObject stub] andReturn:@"udany"] objectForKey:@"test"];
    
    //when
    
    //then
    XCTAssertEqualObjects(@"udany", [mockParseObject objectForKey:@"test"]);
}

- (void) testStringForKey {
    //given
    NSInteger categoryKey1 = IGCategoryKeyName;
    NSInteger categoryKey2 = IGCategoryKeyIcon;
    NSInteger wrongCategoryKey = 69;
    
    //when
    NSString *stringForKey1 = [IGCategory stringForKey:categoryKey1];
    NSString *stringForKey2 = [IGCategory stringForKey:categoryKey2];
    NSString *wrongStringForKey;
    @try {
        wrongStringForKey = [IGCategory stringForKey:wrongCategoryKey];
        XCTFail(@"Did not throw an exception");
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    //then
    XCTAssertEqualObjects(stringForKey1, @"name");
    XCTAssertEqualObjects(stringForKey2, @"icon");
    XCTAssertNil(wrongStringForKey);
}

@end
