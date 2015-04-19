//
//  Attraction.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "Attraction.h"

@implementation Attraction

-(instancetype)initWithParseObject:(PFObject*)object{
    self = [super init];
    _name = object[[Attraction stringForKey:IGAttractionKeyName]];
    _placeDescription = object[[Attraction stringForKey:IGAttractionKeyDescription]];
    _category = [IGCategory categoryWithParseObject:
                 object[[Attraction stringForKey:IGAttractionKeyCategory]]];
    
    _objectId = object.objectId;
    
    //_categoryName = [category valueForKey:@"name"];
    return self;
}

+(instancetype)attractionWithParseObject:(PFObject*)object{
    return [[Attraction alloc] initWithParseObject:object];
}

+(NSString *)stringForKey:(IGAttractionKey)key{
    static NSArray *strings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        strings = @[@"name",@"description",@"category",@"verified"];
    });
    return strings[key];
}

-(PFObject*)parseObject{
    PFObject *attraction = [PFObject objectWithClassName:@"Place"];
    if(self.objectId){
        attraction.objectId = self.objectId;
    }
    attraction[[Attraction stringForKey:IGAttractionKeyCategory]] = self.category.parseObject;
    attraction[[Attraction stringForKey:IGAttractionKeyDescription]] = self.placeDescription;
    attraction[[Attraction stringForKey:IGAttractionKeyName]] = self.name;
    return attraction;
}

@end
