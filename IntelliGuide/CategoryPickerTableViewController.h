//
//  CategoryPickerTableTableViewController.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "IGCategory.h"

/*!
 Protocol used to notify it's delegate about chosen IGCategory object
 */
@protocol CategoryPickerDelegate <NSObject>

/*!
 Delegate callback that passes chosen category to it.
 
 @param category An IGCategory object that was chosen by user.
 */
-(void)didPickCategory:(IGCategory*)category;

@end

/*!
 View Controller that displays user available category and lets him/her choose one of them.
 */
@interface CategoryPickerTableViewController : PFQueryTableViewController

///------
///@name Fields
///------

/*!
 Delegate object, conforming to the CategorySwitcherDelegate protocol, which is notified if the category is choosed.
 */
@property (nonatomic,weak) id<CategoryPickerDelegate> delegate;


@end
