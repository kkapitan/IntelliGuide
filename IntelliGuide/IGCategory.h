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

@property (readonly)NSString *objectId;

/** NSString that contains category name. */
@property NSString *name;


/** UIImage representing category icon. */
@property (readonly) UIImage *image;


/** Base object that was used to create IGCategory object. */
@property (readonly )PFObject *parseObject;

//------
//@name Class methods
//------

/** Method used to create IGCategory object using information stored by Parse object.
 
 @param Parse object upon which new instance of IGCategory will be based on
 
 @return Newly initialized IGCategory object */

+(instancetype)categoryWithParseObject:(PFObject*)object;

/** Method that returns string used to access specified field in parse object dictionary.

 @param key Constant of type IGCategoryKey that specifies what field we want to access

 @return NSString that is the key to specified field */

+(NSString*)stringForKey:(IGCategoryKey)key;

@end
