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

/*!
 This is a wrapper class for Parse Object of class "Review".
 We use wrapper objects for parse data to provide easy access to most important fields,
 introduce type checking and reduce memory usage (nothing more than needed information are stored).
 */

@interface IGReview : NSObject


///-----
///@name Constants
///-----

/*!
 These constants are used to get keys for values stored in Parse objects.
 This way we can modify those keys in only one place and be sure that all of our code
 is still working.
 */

typedef NS_ENUM(NSInteger, IGReviewKey){
    
    /*!
     This is constant used to access key for reviewer's name.
     */
    IGReviewKeyReviewer = 0,
    
    /*!
     This is constant used to access key for Review content.
     */
    IGReviewKeyContent,

    /*!
     This is constant used to access key for reviewer's rating.
     */
    IGReviewKeyRating,
};

/*!
 NSString that holds original parse object's objectId property. You can use it
 to recreate Parse Object from IGReview object and update it's data on the backend.
 */

///------
///@name Fields
///------



@property NSString *objectId;

/*!
 NSString that contains reviewer's name.
 */

@property PFUser *reviewer;

/*!
 NSString that contains review's content.
 */

@property NSString *content;

/*!
 NSNumber that contains  reviewer's rating.
 */

@property NSNumber *rating;

//------
//@name Class methods
//------


/*! Method that is used to create new instance of IGReview from PFObject of class "Review".

@param object PFObject upon which new IGReview object will be based on

@return Newly initialized IGReview object
*/
 +reviewWithParseObject:(PFObject*)object;

/*! Method that returns string used to access specified field in parse object dictionary.
 
 @param key Constant of type IGReviewKey that specifies what field we want to access
 
 @return NSString that is the key to specified field */


+(NSString*)stringForKey:(IGReviewKey)key;

/*!
 Method that created PFObject from data held in this object.
 Used to save changes to attraction to Parse.
 
 @return PFObject containg data about this review
 */
-(PFObject*)parseObject;


@end
