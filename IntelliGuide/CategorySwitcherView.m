//
//  CategorySwitcherView.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "CategorySwitcherView.h"

@interface CategorySwitcherView ()
@property (weak, nonatomic) UILabel *categoryLabel;
@property (weak, nonatomic) UISwitch *switchControl;
@end

@implementation CategorySwitcherView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        [self loadFromNib];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    //Needed to prevent inifinite loadingFromNib calls
    static BOOL once;
    if(self && !once){
        once = YES;
        [self loadFromNib];
    }
    once = NO;
    return self;
}

-(void)loadFromNib{
    NSArray *nibFile = [[NSBundle mainBundle] loadNibNamed:@"CategorySwitcherView" owner:self options:nil];
    
    UIView *subview = [nibFile firstObject];
    subview.frame = self.bounds;
    
    //Workaround for problem with iboutlets and ibaction
    self.categoryLabel = (UILabel*)[subview viewWithTag:10];
    self.switchControl = (UISwitch*)[subview viewWithTag:11];
    [self.switchControl addTarget:self action:@selector(categorySwitched:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:subview];
}

- (IBAction)categorySwitched:(id)sender {
    
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

-(void)awakeFromNib{
    [super awakeFromNib];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
