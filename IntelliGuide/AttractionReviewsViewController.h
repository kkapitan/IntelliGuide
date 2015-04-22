//
//  AttractionReviewsViewController.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import "IGAttraction.h"

/*!
 This view controller querys for attraction's reviews and displays it in table view.
 */
@interface AttractionReviewsViewController : PFQueryTableViewController

///------
///@name Fields
///------

/*!
 ViewController's query will be setup with data held in this property.
 */
@property (nonatomic) IGAttraction *attraction;

@end
