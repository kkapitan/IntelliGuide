//
//  GalleryCollectionViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "GalleryCollectionViewController.h"
#import "GalleryCollectionViewCell.h"
#import "PresentPhotoViewController.h"

@interface GalleryCollectionViewController ()

@end

@implementation GalleryCollectionViewController

static NSString * const reuseIdentifier = @"GalleryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
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
    if([segue.identifier isEqualToString:@"presentPhotoSegue"]){
       
        UINavigationController *navVC = (UINavigationController*)segue.destinationViewController;
        /*
        NSIndexPath *ip = [[self.collectionView indexPathsForSelectedItems] firstObject];
        
        for(int i = 0; i < ip.row; i++){
            PresentPhotoViewController* pVC = (PresentPhotoViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"PhotoController"];
            pVC.number = i;
            pVC.images = self.galleryImages;
            [navVC pushViewController:pVC animated:NO];
        }; */
        
        
        PresentPhotoViewController* pVC = (PresentPhotoViewController*)[navVC topViewController];
        
        pVC.number = 0;
        pVC.images = self.galleryImages;
    }
}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.galleryImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.galleryImage = self.galleryImages[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
