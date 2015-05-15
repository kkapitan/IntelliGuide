//
//  GalleryCollectionViewCell.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "GalleryCollectionViewCell.h"

@interface GalleryCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *galleryPhotoImageView;

@end

@implementation GalleryCollectionViewCell

-(void)setGalleryImage:(UIImage *)galleryImage{
    _galleryImage = galleryImage;
    _galleryPhotoImageView.image = galleryImage;
}
@end
