//
//  MapViewController.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 06.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGAttraction.h"

/*!
 This view controller is responsible for displaying map around
 attraction and drop a pin in that location to visualize where
 attraction is located.
 */
@interface MapViewController : UIViewController

///------
///@name Fields
///------

/*!
 Attraction that will be displayed on map
*/
@property (nonatomic) IGAttraction *attraction;

@end
