//
//  CircleTransitionAnimator.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 19.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "CircleTransitionAnimator.h"
#import "PresentPhotoViewController.h"

@interface CircleTransitionAnimator ()
@property (nonatomic,weak) id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation CircleTransitionAnimator

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    
    UIView *containerView = [transitionContext containerView];
    PresentPhotoViewController *fromVC = (PresentPhotoViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PresentPhotoViewController *toVC = (PresentPhotoViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    int tag = 10;
    
    
    UIButton *button = (UIButton*)[fromVC.view viewWithTag:tag];
    [containerView addSubview:toVC.view];
    
    
    CGPoint extremePoint = CGPointMake(button.center.x, button.center.y - CGRectGetHeight(toVC.view.bounds));
        float radius = sqrtf((extremePoint.x*extremePoint.x + extremePoint.y*extremePoint.y));
    //NSLog(@"%f %f %f",extremePoint.x,extremePoint.y,radius);
    
    if(self.pop){
        tag = 20;
        button = (UIButton*)[fromVC.view viewWithTag:tag];
    }
    
    UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    
    UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = circleMaskPathFinal.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(circleMaskPathInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(circleMaskPathFinal.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    BOOL complete = YES;
    if([self.transitionContext transitionWasCancelled])complete = NO;
    
    [self.transitionContext completeTransition:complete];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
}

@end
