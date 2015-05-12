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
    
    _objectId = object.objectId;
    _reviewerName = reviewer[[IGReview stringForKey:IGReviewKeyReviewerName]];
    _content = object[[IGReview stringForKey:IGReviewKeyContent]];
    _rating = [NSNumber numberWithFloat:[object[[IGReview stringForKey:IGReviewKeyRating]] floatValue]];
    
    return self;
}

+reviewWithParseObject:(PFObject*)object {
    return [[IGReview alloc] initWithParseObject:object];
}

+(NSString*)stringForKey:(IGReviewKey)key{
    static NSArray *strings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        strings = @[@"username",@"content",@"stars"];
    });
    return strings[key];
}

-(PFObject *)parseObject{
    PFObject *object = [PFObject objectWithClassName:@"Review"];
    object[[IGReview stringForKey:IGReviewKeyRating]] = self.rating;
    object[[IGReview stringForKey:IGReviewKeyContent]] = self.content;
    return object;
}

@end
