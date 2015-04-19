//
//  IGReview.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface IGReview : NSObject

typedef NS_ENUM(NSInteger, IGReviewKey){
    IGReviewKeyObjectId = 0,
    IGReviewKeyReviewerName,
    IGReviewKeyContent,
    IGReviewKeyRating,
};

@property NSString *objectId;
@property NSString *reviewerName;
@property NSString *content;
@property NSNumber *rating;

+reviewWithParseObject:(PFObject*)object;
+(NSString*)stringForKey:(IGReviewKey)key;

@end
