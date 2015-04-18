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
    _name = [object valueForKey:@"name"];
    PFFile *iconFile = object[@"icon"];
    [iconFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        _image = [UIImage imageWithData:data];
        //to na pewno nie jest najlepszy sposób na powiadamianie komórki o tym, że ma się odświeżyć
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DownloadedCategoryImage" object:self];
    }];
    
    return self;
}

+categoryWithParseObject:(PFObject*)object {
    if (storage == nil) storage = [NSMutableDictionary new];
    if (storage[object[@"name"]] == nil) [storage setObject:[[IGCategory alloc] initWithParseObject:object] forKey:object[@"name"]];
    return storage[object[@"name"]];
}

@end
