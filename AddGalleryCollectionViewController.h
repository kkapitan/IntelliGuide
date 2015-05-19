//
//  AddGalleryCollectionViewController.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 Protocol that is used to notify delegate that user has finished
 picking image from gallery picker.
 */
@protocol GalleryDelegate <NSObject>

/*! This method notifies delegate that user has finished picking images for
 gallery.
 
 @param images NSArray containing selected images
 
 @return void */
-(void) didFinishPickingImages:(NSArray*)images;

/*! This method notifies delegate that user had finished picking cover photo
 for attraction.
 
 @param image Selected image.
 
 @return void */

- (void) didFinishPickingMainImage:(UIImage*)image;

@end

/*!
 This view controller handles displaying and adding images
 to attraction gallery. It displays pictures using UICollectionView.
 While adding gallery, you can select cover photo of attraction and
 then add additional photos that can be viewed by this controller while
 displaying attraction details.
 */
@interface AddGalleryCollectionViewController : UICollectionViewController

///------
///@name Fields
///------

/*!
 If you want to display images in gallery, then pass NSMutableArray
 containing those images.
 */

@property (strong, nonatomic) NSMutableArray *galleryImages;

/*!
 This property holds cover photo for attraction.
 */

@property (strong, nonatomic) UIImage *mainImage;

/*!
 This property holds delegate that will be notified of images that
 user picks with gallery picker while adding new pictures to gallery.
 */

@property (weak, nonatomic) id<GalleryDelegate> delegate;
@end
