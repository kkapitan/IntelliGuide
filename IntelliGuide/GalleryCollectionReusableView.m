//
//  GalleryCollectionReusableView.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "GalleryCollectionReusableView.h"

@interface GalleryCollectionReusableView () 
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@end

@implementation GalleryCollectionReusableView


-(void)setHeaderImage:(UIImage *)headerImage{
    _headerImage = headerImage;
    self.headerImageView.image = headerImage;
}

@end
