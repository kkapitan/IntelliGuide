//
//  AttractionDescriptionViewController.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 View controller responsible for displaying attraction's description
 in it's TextField.
 */
@interface AttractionDescriptionViewController : UIViewController

///------
///@name Fields
///------

/*!
 This NSString will be displayed in VC's TextField.
 */
@property NSString *descriptionText;

@end
