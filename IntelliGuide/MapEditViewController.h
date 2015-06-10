//
//  MapEditViewController.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 06.06.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol EditLocationDelegate <NSObject>

- (void) didSelectLocation:(CLLocation*)location;

@end

@interface MapEditViewController : UIViewController

@property id<EditLocationDelegate> delegate;
@property CLLocation* initialLocation;

@end
