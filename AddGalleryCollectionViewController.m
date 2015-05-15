//
//  AddGalleryCollectionViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "AddGalleryCollectionViewController.h"
#import "GalleryCollectionViewCell.h"
#import "GalleryCollectionReusableView.h"
#import <QuartzCore/QuartzCore.h>

@interface AddGalleryCollectionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic) BOOL editingItem;
@property (nonatomic) BOOL pickingMainPhoto;
@property (nonatomic) BOOL deletingItem;
@property (nonatomic,strong) UITapGestureRecognizer *tapHeaderRecognizer;
@property (nonatomic,strong) UILongPressGestureRecognizer *longPressRecognizer;
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;

@end

@implementation AddGalleryCollectionViewController

static NSString * const reuseIdentifier = @"GalleryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(enableDelete:)];
    self.longPressRecognizer.minimumPressDuration = 1.0f;
    self.longPressRecognizer.allowableMovement = 100.0f;
    
    [self.view addGestureRecognizer:self.longPressRecognizer];
    
    if(!self.galleryImages)
        self.galleryImages = [NSMutableArray array];

    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.allowsEditing = NO;
    self.imagePicker.delegate = self;
    
    self.tapHeaderRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickMainPhoto:)];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disableDelete:)];
    self.tapRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <Navigation Selectors>


- (IBAction)done:(id)sender {
    [self.delegate didFinishPickingMainImage:self.mainImage];
    [self.delegate didFinishPickingImages:self.galleryImages];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    
    //Needed to prevent tap recognizer from overriding default CollectionView selection recognizer
    if([touch.view.superview.superview isKindOfClass:[UICollectionReusableView class]])return  NO;
    
    return YES;
}

#pragma mark <UIGestureRecognizerSelectors>

-(void)pickMainPhoto:(id)sender{
    self.pickingMainPhoto = YES;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}

-(void)markDeletable{
    for(NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems){
        if(indexPath.row != self.galleryImages.count){
            GalleryCollectionViewCell *cell = (GalleryCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
            [cell setDeletable:YES];
        }
    }
}

-(void)enableDelete:(id)sender{
    NSLog(@"Delete enabled");
    self.deletingItem = YES;
    
    [self markDeletable];
    [self.view addGestureRecognizer:self.tapRecognizer];
    [self.view removeGestureRecognizer:self.longPressRecognizer];
}

-(void)disableDelete:(id)sender{
    NSLog(@"Delete disabled");
    self.deletingItem = NO;
    
    for(GalleryCollectionViewCell *cell in self.collectionView.visibleCells ){

        [cell setDeletable:NO];
    }
    
    [self.view addGestureRecognizer:self.longPressRecognizer];
    [self.view removeGestureRecognizer:self.tapRecognizer];
}

#pragma mark <UIImagePickerDelegate>

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if(self.editingItem){
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
        self.galleryImages[indexPath.row] = image;
    }else if( self.pickingMainPhoto ){
        self.mainImage = image;
    }
    else {
        [self.galleryImages addObject:image];
    }
    self.pickingMainPhoto = NO;
    self.editingItem = NO;
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.galleryImages.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCollectionViewCell *cell = (GalleryCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    // Configure the cell
    if(indexPath.row != self.galleryImages.count){
        cell.galleryImage = self.galleryImages[indexPath.row];
        if(self.deletingItem)[cell setDeletable:YES];
    }
    else
        cell.galleryImage = nil;
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    GalleryCollectionReusableView *headerView = (GalleryCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GalleryHeader" forIndexPath:indexPath];
    
    if(self.mainImage)
        headerView.headerImage = self.mainImage;
    
    [headerView addGestureRecognizer:self.tapHeaderRecognizer];
    return headerView;
}

#pragma mark <UICollectionViewDelegate>


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(!self.deletingItem){
        
        if(indexPath.row == self.galleryImages.count)self.editingItem = YES;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
   
    }else if(indexPath.row != self.galleryImages.count){
        
        [self.galleryImages removeObjectAtIndex:indexPath.row];
        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
        [self markDeletable];
    }
}

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
