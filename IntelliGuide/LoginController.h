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
#import "MyPFLoginViewController.h"
#import "MyPFSingUpViewController.h"

/*!
 Object that creates and handles all callbacks from PFLoginViewController
 */
@interface LoginController : NSObject

///------
///@name Fields
///------

/*!
 Property holding view controller that creates and wants to present login view controller.
 */
@property UIViewController *parentViewController;

/*!
 Property holding created PFLoginViewController
 */
@property (weak, nonatomic) MyPFLoginViewController* loginViewController;

//------
//@name Methods
//------

/*!
 Method that creates, configures and shows PFLoginViewController from parentViewController
 */
- (void) presentLoginViewController;

@end
