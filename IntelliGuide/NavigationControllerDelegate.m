//
//  NavigationControllerDelegate.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 19.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "CircleTransitionAnimator.h"

@implementation NavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)
navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    CircleTransitionAnimator* animator = [[CircleTransitionAnimator alloc] init];
    if(operation == UINavigationControllerOperationPop)
        animator.pop = YES;
    return animator;
}
@end
