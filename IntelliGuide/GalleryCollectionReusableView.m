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



-(void)didMoveToWindow{
    [self prettify];
}

-(void)setHeaderImage:(UIImage *)headerImage{
    _headerImage = headerImage;
    self.headerImageView.image = headerImage;
}

-(void)prettify{
    self.layer.masksToBounds = NO;
    //self.layer.borderColor = [UIColor whiteColor].CGColor;
   // self.layer.borderWidth = 7.0f;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layer.shadowOpacity = 0.75f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeZero;
    //self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}



@end
