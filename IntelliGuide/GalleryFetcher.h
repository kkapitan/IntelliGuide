//
//  GalleryFetcher.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GalleryFetcher : NSObject

+(void)fetchGalleryForPlaceWithId:(NSString*)objectId completion:(void (^)(NSArray*))block;

@end
