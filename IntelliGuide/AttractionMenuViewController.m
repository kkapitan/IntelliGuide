//
//  AttractionMenuViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "AttractionMenuViewController.h"
#import "NewReviewViewController.h"
#import "GalleryCollectionViewController.h"

@interface AttractionMenuViewController ()

@end

@implementation AttractionMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"addReviewSegue"]){
        NewReviewViewController *newReviewViewController = segue.destinationViewController;
        newReviewViewController.attraction = self.attraction;
    }else {
        GalleryCollectionViewController *galleryViewController = (GalleryCollectionViewController*)segue.destinationViewController;
        galleryViewController.galleryImages = self.galleryImages;
        NSLog(@"%@",self.galleryImages);
    }
}


@end
