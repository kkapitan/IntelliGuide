//
//  CircleTransitionAnimator.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 19.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 This class is used to animate transitions between photos in the gallery.
 */
@interface CircleTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

///------
///@name Fields
///------

/*!
 Property that holds information about the type of transition (push/pop) in the navigation controller
 */
@property (nonatomic) BOOL pop;
@end
