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

/**
This is a wrapper class for Parse Object of class "Category".
We use wrapper objects for parse data to provide easy access to most important fields,
introduce type checking and reduce memory usage (nothing more than needed information are stored).
*/



@interface IGCategory : NSObject

///-----
///@name Constants
///-----

/**
 These constants are used to get keys for values stored in Parse objects.
 This way we can modify those keys in only one place and be sure that all of our code
 is still working.
 */

typedef NS_ENUM(NSInteger, IGCategoryKey){
    /**
     This is constant used to access key for Category name.
     */
    IGCategoryKeyName = 0,
    /**
     This is constant used to access key for Category icon file.
     */
    IGCategoryKeyIcon,
    
};

///------
///@name Fields
///------


/**
 NSString that holds original parse object's objectId property. You can use it
 to recreate Parse Object from IGCategory object and update it's data on the backend.
 */

@property NSString *objectId;
@property NSString *name;
@property UIImage *image;
@property PFObject *parseObject;

///------
///@name Methods
///------


+(instancetype)categoryWithParseObject:(PFObject*)object;
+(NSString*)stringForKey:(IGCategoryKey)key;
-(instancetype)initWithParseObject:(PFObject*)object;

@end
