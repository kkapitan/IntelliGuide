//
//  NewAttractionViewController.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGAttraction.h"

/*!
 Protocol that is used to notify parent view controller that editing has
 ended and it can refresh it's contents.
 */
@protocol EndEditingProtocol <NSObject>

/*!
 Method invoked after editing has been finished
 
 @return void
 */
- (void) didEndEditingAttraction;

@end

/*! View controller which controls the proces of creating, validating and uploading new attraction. */ 

@interface NewAttractionViewController : UIViewController

///------
///@name Fields
///------

/*!
 If we want to edit attraction, then we assign IGAttraction object
 to this property.
 */
@property(nonatomic) IGAttraction* toEdit;

/*!
 This property holds EndEditingProtocol that wants to be notified
 when editing has finished.
 */
@property (nonatomic) id<EndEditingProtocol> delegate;

@end
