//
//  LoginController.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface LoginController : NSObject

@property UIViewController *parentViewController;

@property (weak, nonatomic) PFLogInViewController* loginViewController;
- (void) presentLoginViewController;

@end
