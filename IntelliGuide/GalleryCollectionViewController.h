//
//  GalleryCollectionViewController.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 Collection View controller that is responsible for populating collection view
 with proper objects (attraction images in this case).
 */
@interface GalleryCollectionViewController : UICollectionViewController

///------
///@name Fields
///------

/*!
 This property holds array of images that this collection view will display.
 */
@property (nonatomic,strong) NSArray* galleryImages;
@end
