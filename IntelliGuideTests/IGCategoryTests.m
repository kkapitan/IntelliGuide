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
    
    //create image data to pass to mocked getData method
    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"icon_x"]);
    
    //pure magic
    //we want to mock method getDataInBackgroundWithBlock which runs block that creates
    //and sets image property from given data so we can test if this block is OK
    
    //to do that first we need to create proxy block that is executed by .andDo() OCMock macro
    //it passes NSInvocation object as a parameter to that block, second parameter of this NSInvocation
    //is our block (getDataInBackgroundWithBlock) that is called in real IGCategory object
    //now we simply invoke our block with imageData
    //AND IT WORKS
    void (^proxyBlock)(NSInvocation *) = ^(NSInvocation *invocation) {
        void (^block)(NSData*, NSError*);
        [invocation getArgument:&block atIndex:2];
        block(imageData, nil);
    };
    
    id mockParseObject = OCMClassMock([PFObject class]);
    id mockPFFile = OCMClassMock([PFFile class]);
    
    OCMStub([mockParseObject objectId]).andReturn(@"abc123");
    OCMStub(mockParseObject[[IGCategory stringForKey:IGCategoryKeyName]]).andReturn(@"Park Wilsona");
    OCMStub(mockParseObject[[IGCategory stringForKey:IGCategoryKeyIcon]]).andReturn(mockPFFile);
    OCMStub([mockPFFile getDataInBackgroundWithBlock:[OCMArg any]]).andDo(proxyBlock);
    
    //when
    IGCategory *category = [IGCategory categoryWithParseObject:mockParseObject];
    
    //then
    XCTAssertEqualObjects(category.objectId, @"abc123");
    XCTAssertEqualObjects(category.name, @"Park Wilsona");
    XCTAssertEqualObjects(category.parseObject, mockParseObject);
    XCTAssertNotNil(category.image);
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

- (void) testCache {
    XCTFail(@"Not implemented.");
}

@end
