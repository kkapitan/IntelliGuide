//
//  IGCategory.h
//  IntelliGuide
//
//  Created by Krystian Paszek on 18.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>



@interface IGCategory : NSObject

typedef NS_ENUM(NSInteger, IGCategoryKey){
    IGCategoryKeyObjectId = 0,
    IGCategoryKeyName,
    IGCategoryKeyIcon,
};

@property NSString *objectId;
@property NSString *name;
@property UIImage *image;

+(instancetype)categoryWithParseObject:(PFObject*)object;
+(NSString*)stringForKey:(IGCategoryKey)key;
-(instancetype)initWithParseObject:(PFObject*)object;

@end