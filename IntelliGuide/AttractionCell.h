//
//  AttractionCell.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 18.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGAttraction.h"


/*! Custom TableViewCell used to display attraction. */

@interface AttractionCell : UITableViewCell

///------
///@name Fields
///---

/*! Object of type IGAttraction storing attraction to be displayed. */
@property (nonatomic) IGAttraction *attraction;

@end
