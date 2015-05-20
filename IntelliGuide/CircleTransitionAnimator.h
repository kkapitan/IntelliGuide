//
//  CircleTransitionAnimator.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 19.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CircleTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) BOOL pop;
@end