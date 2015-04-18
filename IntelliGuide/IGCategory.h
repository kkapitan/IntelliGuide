//
//  IGCategory.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 18.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface IGCategory : NSObject

@property NSString *name;
@property UIImage *image;

+categoryWithParseObject:(PFObject*)object;
-initWithParseObject:(PFObject*)object;

@end
