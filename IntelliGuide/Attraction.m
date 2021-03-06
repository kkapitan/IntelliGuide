//
//  Attraction.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "Attraction.h"

@implementation Attraction

-initWithParseObject:(PFObject*)object{
    self = [super init];
    _name = [object valueForKey:@"name"];
    _placeDescription = [object valueForKey:@"description"];
    PFObject *category = [object valueForKey:@"category"];

    _categoryName = [category valueForKey:@"nazwa"];
    return self;
}

+attractionWithParseObject:(PFObject*)object{
    return [[Attraction alloc] initWithParseObject:object];
}

@end
