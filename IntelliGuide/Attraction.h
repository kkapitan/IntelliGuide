//
//  Attraction.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "IGCategory.h"

@interface Attraction : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *placeDescription;
//@property (nonatomic) NSString *categoryName;
@property (nonatomic) IGCategory *category;
@property (nonatomic) NSString *objectId;


+attractionWithParseObject:(PFObject*)object;
-initWithParseObject:(PFObject*)object;

@end
