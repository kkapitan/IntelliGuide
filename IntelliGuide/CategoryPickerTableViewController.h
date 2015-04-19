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

@protocol CategoryPickerDelegate <NSObject>

-(void)didPickCategory:(IGCategory*)category;

@end

@interface CategoryPickerTableViewController : PFQueryTableViewController
@property (nonatomic,weak) id<CategoryPickerDelegate> delegate;
@end
