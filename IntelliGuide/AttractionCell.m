//
//  AttractionCell.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 18.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "AttractionCell.h"

@interface AttractionCell()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIcon;

@end

@implementation AttractionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAttraction:(IGAttraction *)attraction {
    _attraction = attraction;
    _name.text = _attraction.name;
    _categoryIcon.image = _attraction.category.image;
}

@end
