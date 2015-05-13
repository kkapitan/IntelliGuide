//
//  NewAttractionViewController.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGAttraction.h"
/*! View controller which controls the proces of creating, validating and uploading new attraction. */ 

@interface NewAttractionViewController : UIViewController
@property(nonatomic) IGAttraction* toEdit;
@end
