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

@property NSString *reviewerName;
@property NSString *content;

+reviewWithParseObject:(PFObject*)object;

@end
