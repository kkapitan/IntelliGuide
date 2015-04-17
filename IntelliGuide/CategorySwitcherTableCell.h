//
//  CategorySwitcherTableCell.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 17.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategorySwitcherDelegate <NSObject>

-(void)didEnableCategory:(NSString*)category;
-(void)didDisableCategory:(NSString*)category;

@end

@interface CategorySwitcherTableCell : UITableViewCell

@property (nonatomic) NSString* categoryName;
@property (weak,nonatomic) id<CategorySwitcherDelegate> delegate;


@end
