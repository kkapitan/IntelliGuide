//
//  PresentPhotoViewController.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 19.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 This view controller is responsible for presenting gallery
 of photos attached to attraction. It provides pleasant animations
 and easy to use gestures.
 */
@interface PresentPhotoViewController : UIViewController

///------
///@name Fields
///------

/*!
 This is index that lets view controller know which photo from
 array it should display.
*/
@property (nonatomic) int number;

/*!
 Array of images that gallery will display
 */
@property (nonatomic) NSArray* images;
@end
