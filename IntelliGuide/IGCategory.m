//
//  IGCategory.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 18.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "IGCategory.h"

static NSMutableDictionary *storage = nil;

@implementation IGCategory

-initWithParseObject:(PFObject*)object {
    self = [super init];
    _name = [object valueForKey:[IGCategory stringForKey:IGCategoryKeyName]];
    _objectId = object.objectId;
    PFFile *iconFile = object[[IGCategory stringForKey:IGCategoryKeyIcon]];
    [iconFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        _image = [UIImage imageWithData:data];
        //to na pewno nie jest najlepszy sposób na powiadamianie komórki o tym, że ma się odświeżyć
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DownloadedCategoryImage" object:self];
    }];
    
    return self;
}

+categoryWithParseObject:(PFObject*)object {
    NSString *nameString = [IGCategory stringForKey:IGCategoryKeyName];
    
    if (storage == nil) storage = [NSMutableDictionary new];
    if (storage[object[nameString]] == nil) [storage setObject:[[IGCategory alloc] initWithParseObject:object] forKey:object[nameString]];
    return storage[object[nameString]];
}

+(NSString*)stringForKey:(IGCategoryKey)key{
    static NSArray *strings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        strings = @[@"objectId",@"name",@"icon"];
    });
    return strings[key];
}


@end
