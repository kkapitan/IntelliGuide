//
//  ReviewCell.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGReview.h"

/*! Custom TableViewCell used to display user's review. */
@interface ReviewCell : UITableViewCell

///------
///@name Fields
///---

/*! Object of type IGReview storing review to be displayed. */
@property (nonatomic) IGReview *review;

@end
