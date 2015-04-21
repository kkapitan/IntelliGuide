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

@interface AttractionReviewsViewController : PFQueryTableViewController

@property (nonatomic) IGAttraction *attraction;

@end
