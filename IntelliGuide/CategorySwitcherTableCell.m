//
//  CategorySwitcherTableCell.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 17.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "CategorySwitcherTableCell.h"

@interface CategorySwitcherTableCell ()

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation CategorySwitcherTableCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.switchControl addTarget:self action:@selector(categorySwitched:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) categorySwitched:(id)sender {
    
    UISwitch *switchControl = (UISwitch*)sender;
    
    if(switchControl.on){
        [self.delegate didEnableCategory:_category];
    } else {
        [self.delegate didDisableCategory:_category];
    }
}

- (void) setCategory:(IGCategory *)category {
    _category = category;
    self.categoryLabel.text = category.name;
    self.categoryImage.image = category.image;
}

@end
