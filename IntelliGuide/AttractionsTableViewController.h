//
//  AttractionsTableViewController.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface AttractionsTableViewController : PFQueryTableViewController
@property (nonatomic) NSDictionary* preferences;
@end
