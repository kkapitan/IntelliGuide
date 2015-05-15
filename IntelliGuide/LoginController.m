//
//  LoginController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "LoginController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface LoginController() <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

@implementation LoginController

- (PFLogInViewController*) loginViewController {
    PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
    [logInViewController setDelegate:self];
    PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
    [signUpViewController setDelegate:self];
    [logInViewController setSignUpController:signUpViewController];
    [logInViewController setFields: PFLogInFieldsDefault | PFLogInFieldsDismissButton];
//    [logInViewController setFields:PFLogInFieldsFacebook | PFLogInFieldsTwitter | PFLogInFieldsDefault | PFLogInFieldsDismissButton];
//    [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"friends_about_me", @"public_profile", nil]];
    
    return logInViewController;
}

- (void) presentLoginViewController {
    [self.parentViewController presentViewController:[self loginViewController] animated:YES completion:NULL];
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"did login: %@", user);
    }];
}

- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"did fail to login, error: %@", [error localizedDescription]);
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"did fail to sign up, error: %@", [error localizedDescription]);
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"did sign up: %@", user);
        NSLog(@"current user: %@", [PFUser currentUser]);
    }];
}

@end
