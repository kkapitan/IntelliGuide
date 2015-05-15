//
//  AttractionDetailsViewController.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGAttraction.h"

/*!
 This view controller is responsible for displaying Attraction name
 and image. It also instantiates and feeds with data it's child view controller,
 PageViewController.
 */
@interface AttractionDetailsViewController : UIViewController

///------
///@name Fields
///------

/*!
 This property holds attraction data that will be displayed.
 */
@property IGAttraction *attraction;
@end
