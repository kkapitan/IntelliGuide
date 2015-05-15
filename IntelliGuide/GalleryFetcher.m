//
//  GalleryFetcher.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "GalleryFetcher.h"
#import <Parse/Parse.h>

@implementation GalleryFetcher

+(void)fetchGalleryForPlaceWithId:(NSString*)objectId completion:(void (^)(NSArray*))block{
    PFQuery* query = [PFQuery queryWithClassName:@"Place"];
    [query selectKeys:@[@"gallery"]];
    
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
        if(!error){
            NSArray *array = (NSArray*)object[@"gallery"];
            NSMutableArray *images = [NSMutableArray array];
            for(int i = 0; i < array.count; i++){
                PFFile *imageFile = array[i];
                NSData *data = [imageFile getData];
                if(data)
                    images[i] = [UIImage imageWithData:data];
            };
            block(images);
        }
    }];
}


@end
