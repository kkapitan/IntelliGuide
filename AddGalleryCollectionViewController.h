//
//  AddGalleryCollectionViewController.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GalleryDelegate <NSObject>

-(void)didFinishPickingImages:(NSArray*)images;
-(void)didFinishPickingMainImage:(UIImage*)image;

@end

@interface AddGalleryCollectionViewController : UICollectionViewController
@property (strong,nonatomic) NSMutableArray *galleryImages;
@property (strong,nonatomic) UIImage *mainImage;
@property (weak,nonatomic) id<GalleryDelegate> delegate;
@end
