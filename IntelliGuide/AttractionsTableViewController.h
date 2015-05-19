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

/*!
 This view controller is supposed to query for attraction list based on
 preferences property. After successfully fetching attraction list displays it
 in a table view. After clicking on table view element, it instantiates, 
 feeds with data andtriggers segue to Attraction Details view controller.
 */
@interface AttractionsTableViewController : PFQueryTableViewController

///------
///@name Fields
///------

/*!
 This field is used to pass query preferences to view controller upon which
 query will be executed.
 */
@property (nonatomic) NSDictionary* preferences;

/*!
 Tells the view controller whether it should query for approved or not
 approved attractions. If YES, also enables ability to accept/reject attraction
 (possible after swiping left on cell).
 */
@property (nonatomic) BOOL moderationMode;

/*!
 Tells the view controller whether it will be displaying user attractions. If it will,
 then view controller will query only for quests that were created by [PFUser currentUser]
 */
@property (nonatomic) BOOL userAttarctionsMode;

@end
