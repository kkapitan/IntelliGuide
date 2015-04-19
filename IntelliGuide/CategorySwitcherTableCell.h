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


@protocol CategorySwitcherDelegate <NSObject>

-(void)didEnableCategory:(IGCategory*)category;
-(void)didDisableCategory:(IGCategory*)category;

@end

@interface CategorySwitcherTableCell : PFTableViewCell

@property (nonatomic) IGCategory *category;
@property (weak,nonatomic) id<CategorySwitcherDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISwitch *switchControl;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;

@end
