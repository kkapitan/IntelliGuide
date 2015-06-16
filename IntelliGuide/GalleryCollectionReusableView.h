//
//  GalleryCollectionReusableView.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 Custom collection view header that displays main photo of the attraction.
 */
@interface GalleryCollectionReusableView : UICollectionReusableView

///------
///@name Fields
///------

/*!
 Property that holds an image displayed as the attraction's main photo.
 */
@property (strong,nonatomic) UIImage *headerImage;

@end
