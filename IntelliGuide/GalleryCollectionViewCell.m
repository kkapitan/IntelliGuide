//
//  GalleryCollectionViewCell.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "GalleryCollectionViewCell.h"

#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define kAnimationRotateDeg 0.5
#define kAnimationTranslateX 1.0
#define kAnimationTranslateY 1.0

@interface GalleryCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *galleryPhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *crossImageView;

@end

@implementation GalleryCollectionViewCell

-(void)didMoveToWindow{
    [self prettify];
}

-(void)setGalleryImage:(UIImage *)galleryImage{
    _galleryImage = galleryImage;
    _galleryPhotoImageView.image = galleryImage;
}

-(void)setDeletable:(BOOL)deletable{
    if(deletable){
        [self shake];
        self.crossImageView.hidden = NO;
    }else{
        [self.layer removeAllAnimations];
        self.transform = CGAffineTransformMakeRotation(0.0);
        self.crossImageView.hidden = YES;
    }
}

-(void)prettify{
    self.layer.masksToBounds = NO;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 7.0f;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layer.shadowOpacity = 0.75f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

-(void)shake{

    //startJiggling
    
    int count = 1;
    CGAffineTransform leftWobble = CGAffineTransformMakeRotation(degreesToRadians( kAnimationRotateDeg * (count%2 ? +1 : -1 ) ));
    CGAffineTransform rightWobble = CGAffineTransformMakeRotation(degreesToRadians( kAnimationRotateDeg * (count%2 ? -1 : +1 ) ));
    CGAffineTransform moveTransform = CGAffineTransformTranslate(rightWobble, -kAnimationTranslateX, -kAnimationTranslateY);
    CGAffineTransform conCatTransform = CGAffineTransformConcat(rightWobble, moveTransform);
    
    self.transform = leftWobble;
    
    [UIView animateWithDuration:0.1
                          delay:(count * 0.08)
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{ self.transform = conCatTransform; }
                     completion:nil];

}

@end
