//
//  CALayer+XibConfiguration.h
//  TripTrop
//
//  Created by Krystian Paszek on 22.04.2015.
//  Copyright (c) 2015 Artur Bartczak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/*!
 Extension for CALayer class that lets me set borderColor
 and shadowColor in Storyboard. It declares new properties named
 borderUIColor and shadowUIColor that are responsible for converting
 UIColor colors provided by storyboard to CGRefs used by original
 properties
 */
@interface CALayer (XibConfiguration)

///------
///@name Fields
///------

/*!
 This property when set with UIColor sets borderColor to corresponding
 CGRef color.
 */
@property(nonatomic, assign) UIColor* borderUIColor;

/*!
 This property when set with UIColor sets shadowColor to corresponding
 CGRef color.
 */
@property(nonatomic, assign) UIColor* shadowUIColor;

@end
