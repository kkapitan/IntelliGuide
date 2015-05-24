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

- (void)didMoveToWindow{
    [self prettify];
}

- (void)setAttraction:(IGAttraction *)attraction {
    _attraction = attraction;
    _name.text = _attraction.name;
    _categoryIcon.image = _attraction.category.image;
}

-(void)prettify{
    self.layer.masksToBounds = NO;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 7.0f;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layer.shadowOpacity = 0.75f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

@end
