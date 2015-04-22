//
//  PageViewController.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGAttraction.h"

/*!
 This view controller is responsible for page viewer component in Attraction
 Details screen. Conforms to UIPageViewer DataSource and Delegate protocols.
 
 It's responsibilities are:
 - initiating child view controllers (attraction description and reviews)
 - feeding them with appropriate data
 - displaying first view controller after loading
 */
@interface PageViewController : UIPageViewController

///------
///@name Fields
///------

/*!
 This IGAttraction property will be used to feed child controllers with data.
 */
@property (nonatomic) IGAttraction *attraction;

@end
