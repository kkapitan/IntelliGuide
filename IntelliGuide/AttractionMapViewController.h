//
//  AttractionMapViewController.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 13.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

/*!
 This view controller displays map along with all retrieved attractions
 that fit selected categories and are around specified search center.
 Attractions are displayed as pins that are dropped with animation on
 the map.
 */
@interface AttractionMapViewController : UIViewController

///------
///@name Fields
///------

/*!
 Array of attractions (PFObject) that will be displayed on the map.
*/
@property NSArray* attractions;

@end
