//
//  NewAttractionViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "NewAttractionViewController.h"
#import "CategoryPickerTableViewController.h"
#import "AddGalleryCollectionViewController.h"
#import "IGAttraction.h"
#import "GalleryFetcher.h"
#import "LocationManager.h"
#import "MapEditViewController.h"
#import "MBProgressHUD.h"
#import <MapKit/MapKit.h>

@interface NewAttractionViewController () <CategoryPickerDelegate,UITextViewDelegate,GalleryDelegate, MKMapViewDelegate, EditLocationDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *categoryPickerButton;
@property (weak, nonatomic) IBOutlet UIButton *addPhotosButton;
@property (nonatomic) IGCategory* category;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property  (nonatomic) UITapGestureRecognizer* gestureRecognizer;

@property (nonatomic) NSArray *galleryImages;
@property (nonatomic) UIImage *mainImage;
@property (nonatomic) CLLocation* attractionLocation;

@end

@implementation NewAttractionViewController


- (IBAction)done:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    IGAttraction *attraction = [self buildAttraction];
    if(attraction){
        PFObject *attractionObject = [attraction parseObject];
        attractionObject[[IGAttraction stringForKey:IGAttractionKeyVerified]] = @NO;
        
        if(self.toEdit){
            [attractionObject setObjectId:self.toEdit.objectId];
        }
        
        if(self.galleryImages){
            NSMutableArray *imageFiles = [NSMutableArray array];
            for(UIImage *image in self.galleryImages){
                PFFile *imageFile = [PFFile fileWithData:UIImageJPEGRepresentation(image, 1.0)];
                [imageFiles addObject:imageFile];
            }
            attractionObject[@"gallery"] = imageFiles;
        }
    
        [attractionObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [[MBProgressHUD HUDForView:self.view] hide:YES];
            [self displayAlertWithTitle:@"Dodawanie zakończone!" message:@"Proszę czekać na weryfikację atrakcji przez moderatora"];
            if ([self.delegate respondsToSelector:@selector(didEndEditingAttraction)] && self.toEdit) {
                [self.delegate didEndEditingAttraction];
            }
            
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {
        NSLog(@"error creating attraction");
        [[MBProgressHUD HUDForView:self.view] hide:YES];
    }
}

-(void)didFinishPickingImages:(NSArray *)images{
    self.galleryImages = images;
    
    NSString *title = [NSString stringWithFormat:@"Dodaj zdjęcia (aktualnie: %d)", (int)self.galleryImages.count+1];
    [self.addPhotosButton setTitle:title forState:UIControlStateNormal];
}

-(void)didFinishPickingMainImage:(UIImage *)image{
    self.mainImage = image;
}

-(void)keyboardWillShow{
    [self.view addGestureRecognizer:self.gestureRecognizer];
}

-(void)keyboardWillHide{
    [self.view removeGestureRecognizer:self.gestureRecognizer];
}


-(void)didTap{
    [self.view endEditing:YES];
    //[self.descriptionTextView endEditing:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self.scrollView setContentOffset:CGPointMake(0,self.descriptionLabel.frame.origin.y) animated:YES];
    
    if ([textView.text isEqualToString:@"Tu wstaw krótki opis dodawanego miejsca."]) {
        textView.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
    if (textView.text.length == 0) {
        textView.text = @"Tu wstaw krótki opis dodawanego miejsca.";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.descriptionTextView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    self.gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap) ];
    if(self.toEdit){
        self.category = self.toEdit.category;
        [self.categoryPickerButton setTitle:self.category.name forState:UIControlStateNormal];
        self.descriptionTextView.text = self.toEdit.placeDescription;
        self.nameTextField.text = self.toEdit.name;
        
        [GalleryFetcher fetchGalleryForPlaceWithId:self.toEdit.objectId completion:^(NSArray *images) {
            self.galleryImages = images;
        }];
        if (self.toEdit.location != nil) {
            _attractionLocation = self.toEdit.location;
            [self updateAnnotation];
        }
        
        [self.doneButton setTitle:@"Aktualizuj"];
    } else {
        [[[LocationManager sharedManager] locationManager] startUpdatingLocation];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdate) name:@"DidUpdateLocations" object:nil];
    }
    
    self.mapView.scrollEnabled = NO;
    self.mapView.delegate = self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) locationUpdate {
    _attractionLocation = [[LocationManager sharedManager] lastLocation];
    [self updateAnnotation];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DidUpdateLocations" object:nil];
}

- (void) updateAnnotation {
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(_attractionLocation.coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:_attractionLocation.coordinate];
    
    [self.mapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didPickCategory:(IGCategory *)category{
    [self.categoryPickerButton setTitle:category.name forState:UIControlStateNormal];
    self.category = category;
}

-(IGAttraction*)buildAttraction{
    
    IGAttraction *attraction = [[IGAttraction alloc] init];
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    if([[self.nameTextField.text stringByTrimmingCharactersInSet:characterSet] length]){
        attraction.name = self.nameTextField.text;
    }else {
        [self displayAlertWithTitle:@"Błąd" message:@"Pole nazwa nie może być puste"];
        return nil;
    }
    
    if([[self.descriptionTextView.text stringByTrimmingCharactersInSet:characterSet] length]){
        attraction.placeDescription = self.descriptionTextView.text;
    }else {
        [self displayAlertWithTitle:@"Błąd" message:@"Pole opis nie może być puste"];
        return nil;
    }
    
    if(self.category){
        attraction.category = self.category;
    }else{
        [self displayAlertWithTitle:@"Błąd" message:@"Proszę wybrać kategorię"];
        return nil;
    }
    
    if(self.mainImage){
        attraction.imageFile = [PFFile fileWithData: UIImageJPEGRepresentation(self.mainImage, 1.0)];
    }
    
//    CLLocation *location = [[LocationManager sharedManager] lastLocation];
    if (_attractionLocation) {
        attraction.location = _attractionLocation;
    } else {
        [self displayAlertWithTitle:@"Błąd" message:@"Nie można wykryć Twojej lokalizacji"];
        return nil;
    }
    
    attraction.creator = [PFUser currentUser];
    
    return attraction;
}

-(void)displayAlertWithTitle:(NSString*)title message:(NSString*)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqual:@"pickCategorySegue"]){
        [self.view endEditing:YES];
        CategoryPickerTableViewController* destinationViewController = (CategoryPickerTableViewController*)segue.destinationViewController;
        destinationViewController.delegate = self;
    } else if([segue.identifier isEqualToString:@"createGallerySegue"]){
        AddGalleryCollectionViewController* destinationViewController = (AddGalleryCollectionViewController*)segue.destinationViewController;
        destinationViewController.galleryImages = [self.galleryImages mutableCopy];
        destinationViewController.mainImage = self.mainImage;
        destinationViewController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"MapEditSegue"]) {
        MapEditViewController *destinationVC = (MapEditViewController*)segue.destinationViewController;
        destinationVC.delegate = self;
        destinationVC.initialLocation = _attractionLocation;
    }
}

- (void)didSelectLocation:(CLLocation *)location {
    _attractionLocation = location;
    [self updateAnnotation];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DidUpdateLocations" object:nil];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
    pin.pinColor = MKPinAnnotationColorPurple;
    return pin;
}

@end
