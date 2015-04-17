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
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;

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
    NSString *categoryName = self.categoryLabel.text;
    
    if(switchControl.on){
        [self.delegate didEnableCategory:categoryName];
    }else {
        [self.delegate didDisableCategory:categoryName];
    }
}

-(void)setCategoryName:(NSString *)categoryName{
    _categoryName = categoryName;
    self.categoryLabel.text = categoryName;
}

@end
