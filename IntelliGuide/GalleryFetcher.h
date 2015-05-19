//
//  GalleryFetcher.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 This object fetches gallery images for given objectId.
 */
@interface GalleryFetcher : NSObject

/*!
 This method is responsible for fetching and downloading all image file
 that are bound with attraction with given objectId.
 
 @param objectId ID of the attraction of which we want images
 
 @param block Completion block that will be executed after successfully fetching images
 
 @return void
 */
+(void)fetchGalleryForPlaceWithId:(NSString*)objectId completion:(void (^)(NSArray*))block;

@end
