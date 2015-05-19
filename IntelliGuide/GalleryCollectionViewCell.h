//
//  GalleryCollectionViewCell.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 Custom collection view cell that displays gallery images
 */
@interface GalleryCollectionViewCell : UICollectionViewCell

/*!
 Property holding image to be displayed by cell
 */
@property (strong,nonatomic) UIImage *galleryImage;

/*!
 This method makes deleting this cell possible. Makes cell shake.
 */
-(void)setDeletable:(BOOL)deletable;
@end
