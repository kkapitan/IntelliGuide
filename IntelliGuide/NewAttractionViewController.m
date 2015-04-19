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

@interface NewAttractionViewController () <CategoryPickerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *categoryPickerButton;
@property (nonatomic) IGCategory* category;

@end

@implementation NewAttractionViewController


- (IBAction)done:(id)sender {
    Attraction *attraction = [self buildAttraction];
    if(attraction){
        PFObject *attractionObject = [attraction parseObject];
        attractionObject[[Attraction stringForKey:IGAttractionKeyVerified]] = @NO;
        [attractionObject save];
        [self displayAlertWithTitle:@"Dodawanie zakończone!" message:@"Proszę czekać na weryfikację atrakcji przez moderatora"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
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
