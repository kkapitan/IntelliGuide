//
//  PreferencesViewController.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 First view controller that will be displayed after launching application.
 It's responsible for fetching and displaying category list with switches that
 allow user to choose what categories he/she wants to search for.
 It's also responsible for feeding data (selected categories) to next view controller.
 
 In future it will also get user location or allow him/her to enter custom place.
 */
@interface PreferencesViewController : UIViewController

///------
///@name Fields
///------

//TODO zamienić to na jakiegoś enuma

/*!
 This property is used to indicate that user wants to enter moderation panel.
 It it is set to YES, then view controller will query only for unverified attractions.
 */
@property (nonatomic) BOOL moderationMode;

/*!
 This property is used to indicate that user wants to display his own quests.
 It is passed further to AttractionsTableViewController so it knows that it
 should query only for quests only created by current user.
 */
@property (nonatomic) BOOL userAttractionsMode;

@end
