//
//  LoginController.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoginController : NSObject

@property UIViewController *parentViewController;

- (void) presentLoginViewController;

@end
