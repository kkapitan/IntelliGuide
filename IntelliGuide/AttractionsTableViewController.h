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

/**
 dupa dupa
 */
@interface AttractionsTableViewController : PFQueryTableViewController

/**
 dupa dupa
 */
@property (nonatomic) NSDictionary* preferences;

/**
 dupa dupa
 */
@property (nonatomic) BOOL moderationMode;
@end
