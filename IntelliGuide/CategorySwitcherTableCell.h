//
//  CategorySwitcherTableCell.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 17.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "IGCategory.h"


/** Protocol used to ensure that a CategorySwitcher's delegate implements required callback methods  */

@protocol CategorySwitcherDelegate <NSObject>

/** Callback method invoked when the user enables given category. */
-(void)didEnableCategory:(IGCategory*)category;
 
 /** Callback method invoked when the user disables given category. */

-(void)didDisableCategory:(IGCategory*)category;

@end


/** Custom TableViewCell used to display single category and UISwitch allowing user to specify, if the attractions of the given category should be included in search results. */

@interface CategorySwitcherTableCell : PFTableViewCell

/** IGCategory object storing category to be displayed. */

@property (nonatomic) IGCategory *category;

/** Delegate object, conforming to the CategorySwitcherDelegate protocol, which is notified if the category was enabled/disabled. */

@property (weak,nonatomic) id<CategorySwitcherDelegate> delegate;

/** UISwitch which is used to enable/disable category. */

@property (weak, nonatomic) IBOutlet UISwitch *switchControl;

/** UIImageView which is displaying category icon. */

@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;

@end
