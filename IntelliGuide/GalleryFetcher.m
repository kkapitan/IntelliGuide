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
            dispatch_group_t group = dispatch_group_create();
            NSArray *array = (NSArray*)object[@"gallery"];
            NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:array.count];
            NSLock *arrayLock = [[NSLock alloc] init];
            for(NSInteger i = 0; i < array.count; i++){
                PFFile *imageFile = array[i];
                __block NSData *data = nil;
                dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                    data = [imageFile getData];
                    [arrayLock lock];
                    if (data) images[i] = [UIImage imageWithData:data];
                    [arrayLock unlock];
                });
            };
            
            dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                block(images);
            });
        }
    }];
}


@end
