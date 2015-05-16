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

@interface NewAttractionViewController () <CategoryPickerDelegate,UITextViewDelegate,GalleryDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *categoryPickerButton;
@property (nonatomic) IGCategory* category;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property  (nonatomic) UITapGestureRecognizer* gestureRecognizer;

@property (nonatomic) NSArray *galleryImages;
@property (nonatomic) UIImage *mainImage;

@end

@implementation NewAttractionViewController


- (IBAction)done:(id)sender {
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
            [self displayAlertWithTitle:@"Dodawanie zakończone!" message:@"Proszę czekać na weryfikację atrakcji przez moderatora"];
            
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

-(void)didFinishPickingImages:(NSArray *)images{
    self.galleryImages = images;
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
    
    textView.text = @"";
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
        
    }
    // Do any additional setup after loading the view.
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
        CategoryPickerTableViewController* destinationViewController = (CategoryPickerTableViewController*)segue.destinationViewController;
        destinationViewController.delegate = self;
    } else if([segue.identifier isEqualToString:@"createGallerySegue"]){
        AddGalleryCollectionViewController* destinationViewController = (AddGalleryCollectionViewController*)segue.destinationViewController;
        destinationViewController.galleryImages = [self.galleryImages mutableCopy];
        destinationViewController.mainImage = self.mainImage;
        destinationViewController.delegate = self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
