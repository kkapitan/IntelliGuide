//
//  LoginControllerTests.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LoginController.h"
#import <OCMock/OCMock.h>

@interface LoginControllerTests : XCTestCase



@end

@implementation LoginControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testLoginController {
    //given
    LoginController *loginController = [[LoginController alloc] init];
    
    //when
    [loginController presentLoginViewController];
    
    //then
    XCTAssertNotNil(loginController.loginViewController);
    XCTAssertTrue([loginController.loginViewController isKindOfClass:[PFLogInViewController class]]);
    XCTAssertEqual(loginController.loginViewController.fields, PFLogInFieldsDefault);
    XCTAssertEqual(loginController.loginViewController.delegate, loginController);
    XCTAssertNotNil(loginController.loginViewController.signUpController);
    XCTAssertTrue([loginController.loginViewController.signUpController isKindOfClass:[PFSignUpViewController class]]);
    XCTAssertEqual(loginController.loginViewController.signUpController.delegate, loginController);
}

@end
