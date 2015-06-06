//
//  CALayer+XibConfiguration.m
//  TripTrop
//
//  Created by Krystian Paszek on 22.04.2015.
//  Copyright (c) 2015 Artur Bartczak. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void) setShadowUIColor:(UIColor *)color {
    self.shadowColor = color.CGColor;
}

- (UIColor*) shadowUIColor {
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end
