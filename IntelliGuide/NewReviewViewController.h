//
//  NewReviewViewController.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 12.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGAttraction.h"
/*!
 View controller that is responsible for adding reviews to attraction.
 */
@interface NewReviewViewController : UIViewController

///------
///@name Fields
///------

/*!
 This property holds attraction about which review will be written.
 This is used to make a pointer field in review object.
 */
@property (nonatomic) IGAttraction* attraction;

@end
