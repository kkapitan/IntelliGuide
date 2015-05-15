//
//  AttractionMenuViewController.h
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGAttraction.h"
@interface AttractionMenuViewController : UIViewController
@property IGAttraction *attraction;
@property (nonatomic,strong) NSArray* galleryImages;
@end
