//
//  Attraction.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "IGAttraction.h"

@implementation IGAttraction

-(instancetype)initWithParseObject:(PFObject*)object{
    self = [super init];
    
    //TODO idealnie by było, gdyby było jeszcze jakieś sprawdzanie klasy
    //PFObject i wywalanie nila w przypadku złej klasy, bo na razie
    //zwróci po prostu nowy obiekt z pustymi polami
    
    _name = object[[IGAttraction stringForKey:IGAttractionKeyName]];
    _placeDescription = object[[IGAttraction stringForKey:IGAttractionKeyDescription]];
    _category = [IGCategory categoryWithParseObject:
                 object[[IGAttraction stringForKey:IGAttractionKeyCategory]]];
    
    _imageFile = object[[IGAttraction stringForKey:IGAttractionKeyImage]];
    _objectId = object.objectId;
    
    //_categoryName = [category valueForKey:@"name"];
    return self;
}

+(instancetype)attractionWithParseObject:(PFObject*)object{
    return [[IGAttraction alloc] initWithParseObject:object];
}

+(NSString *)stringForKey:(IGAttractionKey)key{
    static NSArray *strings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        strings = @[@"name",@"description",@"category",@"verified",@"image"];
    });
    return strings[key];
}

-(PFObject*)parseObject{
    PFObject *attraction = [PFObject objectWithClassName:@"Place"];
    if(self.objectId){
        attraction.objectId = self.objectId;
    }
    attraction[[IGAttraction stringForKey:IGAttractionKeyCategory]] = self.category.parseObject;
    attraction[[IGAttraction stringForKey:IGAttractionKeyDescription]] = self.placeDescription;
    attraction[[IGAttraction stringForKey:IGAttractionKeyName]] = self.name;
    
    if(self.imageFile)
        attraction[[IGAttraction stringForKey:IGAttractionKeyImage]] = self.imageFile;
    
    return attraction;
}

@end
