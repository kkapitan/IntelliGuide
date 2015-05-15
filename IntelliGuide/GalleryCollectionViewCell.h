//
//  GalleryCollectionViewCell.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic) UIImage *galleryImage;

-(void)setDeletable:(BOOL)deletable;
@end
