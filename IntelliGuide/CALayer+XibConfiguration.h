//
//  CALayer+XibConfiguration.h
//  TripTrop
//
//  Created by Krystian Paszek on 22.04.2015.
//  Copyright (c) 2015 Artur Bartczak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (XibConfiguration)

@property(nonatomic, assign) UIColor* borderUIColor;
@property(nonatomic, assign) UIColor* shadowUIColor;

@end
