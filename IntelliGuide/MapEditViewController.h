//
//  MapEditViewController.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 06.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

/*!
 This protocol is used to notify when editing has finished
 */
@protocol EditLocationDelegate <NSObject>

/*!
 This method is called when editing is finished. New attraction
 location is passed as a parameter.
 
 @param location CCLocation after edit that is passed to delegate
 
 @return void
 */
- (void) didSelectLocation:(CLLocation*)location;

@end

/*!
 This view controller lets user edit location of attraction. It displays
 map and if a user taps it, pin is dropped to that position and
 attraction has its location updated.
 */
@interface MapEditViewController : UIViewController

///------
///@name Fields
///------

/*!
 EditLocationDelegate that is notified after editing has finished.
*/
@property id<EditLocationDelegate> delegate;

/*!
 Initial location of edited attraction, so the view controller knows
 where to drop pin before user selects new location.
 */
@property CLLocation* initialLocation;

@end
