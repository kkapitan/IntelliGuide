//
//  IGReview.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "IGReview.h"

@implementation IGReview

-initWithParseObject:(PFObject*)object {
    self = [super init];
    PFUser *reviewer = object[@"writtenBy"];
    _reviewerName = reviewer[@"username"];
    _content = object[@"content"];
    
    return self;
}

+reviewWithParseObject:(PFObject*)object {
    return [[IGReview alloc] initWithParseObject:object];
}

@end
