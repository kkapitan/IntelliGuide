//
//  NewAttractionViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "NewAttractionViewController.h"
#import "CategoryPickerTableViewController.h"
#import "Attraction.h"

@interface NewAttractionViewController () <CategoryPickerDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *categoryPickerButton;
@property (nonatomic) IGCategory* category;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property  (nonatomic) UITapGestureRecognizer* gestureRecognizer;

@end

@implementation NewAttractionViewController


- (IBAction)done:(id)sender {
    Attraction *attraction = [self buildAttraction];
    if(attraction){
        PFObject *attractionObject = [attraction parseObject];
        attractionObject[[Attraction stringForKey:IGAttractionKeyVerified]] = @NO;
        [attractionObject save];
        [self displayAlertWithTitle:@"Dodawanie zakończone!" message:@"Proszę czekać na weryfikację atrakcji przez moderatora"];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    [self.scrollView setContentOffset:CGPointMake(0,self.descriptionTextView.frame.origin.y) animated:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.descriptionTextView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    self.gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap) ];
    
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

-(Attraction*)buildAttraction{
    
    Attraction *attraction = [[Attraction alloc] init];
    
    if(self.nameTextField.text){
        attraction.name = self.nameTextField.text;
    }else {
        [self displayAlertWithTitle:@"Błąd" message:@"Pole nazwa nie może być puste"];
        return nil;
    }
    
    if(self.descriptionTextView.text){
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
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
