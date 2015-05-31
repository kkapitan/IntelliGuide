//
//  Attraction.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "IGCategory.h"

/*!
 This is a wrapper class for Parse Object of class "Place".
 We use wrapper objects for parse data to provide easy access to most important fields,
 introduce type checking and reduce memory usage (nothing more than needed information are stored).
 */
@interface IGAttraction : NSObject

///-----
///@name Constants
///-----

/*!
 These constants are used to get keys for values stored in Parse objects.
 This way we can modify those keys in only one place and be sure that all of our code
 is still working.
 */
typedef NS_ENUM(NSInteger, IGAttractionKey){
    /*!
     This is constant used to access key for Place name.
     */
    IGAttractionKeyName = 0,
    
    /*!
     This constant is used to access key for Place description.
     */
    IGAttractionKeyDescription,
    
    /*!
     This constant is used to access key for Place category.
     */
    IGAttractionKeyCategory,
    
    /*!
     This constant is used to access key for boolean value that tells us whether
     the place has been verified by a moderator.
     */
    IGAttractionKeyVerified,
    
    /*!
     This constant is used to access cover image of attraction.
     */
    IGAttractionKeyImage,
    
    /*!
     This constant is used to get PFUser that created attraction
     */
    IGAttractionKeyCreator,
    
    /*!
     This constant is used to access attraction's location
     */
    IGAttractionKeyLocation,
};

///------
///@name Fields
///------

/*!
 NSString that holds name of a place.
 */
@property (nonatomic) NSString *name;

/*!
 NSString that holds description of a place.
 */
@property (nonatomic) NSString *placeDescription;

/*!
 An IGCategory object that holds information about this place's category.
 */
@property (nonatomic) IGCategory *category;

/*!
 NSString that holds original parse object's objectId property. You can use it
 to recreate Parse Object from IGAttraction object and update it's data on the backend.
 */
@property (nonatomic,readonly) NSString *objectId;


/*!
 Property holding cover photo of attraction
 */
@property PFFile *imageFile;

/*!
 Property holding PFUser that is the creator of attraction
 */

@property PFUser *creator;

/*!
 Property holding attraction's location
 */
@property CLLocation *location;

//------
//@name Class methods
//------

/*!
 Initializes an IGAttraction object with data contained in parse object.
 
 @param object PFObject upon which IGAttraction object is going to be based
 
 @return Newly initialized IGAttraction object
 */
+(instancetype)attractionWithParseObject:(PFObject*)object;

/*!
 Method that returns string used to access specified field in parse object dictionary.
 
 @param key Constant of type IGAttractionKey that specifies what field we want to access
 
 @return NSString that is the key to specified field
 */
+(NSString*)stringForKey:(IGAttractionKey)key;

//------
//@name Instance methods
//------

/*!
 Method that is used to create new instance of IGAttraction from PFObject of class "Place"
 
 @param object PFObject upon which new IGAttraction object will be based on
 
 @return Newly initialized IGAttraction object
 */
-(instancetype)initWithParseObject:(PFObject*)object;

/*!
 Used to access internally stored Parse Object 
 @return Original, base Parse Object
 */
-(PFObject*)parseObject;

@end
