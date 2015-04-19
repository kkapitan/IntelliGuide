//
//  PageViewController.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Attraction.h"

@interface PageViewController : UIPageViewController

@property (nonatomic) Attraction *attraction;

@end
