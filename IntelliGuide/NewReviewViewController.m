//
//  NewReviewViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 12.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "NewReviewViewController.h"
#import "IGReview.h"
#import "ASStarRatingView.h"

@interface NewReviewViewController() <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet ASStarRatingView *starsView;
@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *opinionLabel;

@property (nonatomic) UITapGestureRecognizer *tapRecognizer;

@end

@implementation NewReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardDidHideNotification object:nil];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardDidShowNotification object:nil];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    self.reviewTextView.delegate = self;
    
}

- (IBAction)addReview:(id)sender {
    IGReview *review = [self buildReview];
    if(!review)return;
    
    PFObject *reviewObject = review.parseObject;
    //TODO: Dodać użytkownika po zaimplementowaniu logowania.
    reviewObject[@"writtenBy"] = [PFUser currentUser];
    reviewObject[@"aboutPlace"] = self.attraction.parseObject;
    [reviewObject saveInBackground];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self.scrollView setContentOffset:CGPointMake(0,self.opinionLabel.frame.origin.y) animated:YES];
    
    textView.text = @"";
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
    if (textView.text.length == 0) {
        textView.text = @"Tu wstaw krótki opis dodawanego miejsca.";
    }
}

-(void)didTap:(id)sender{
    [self.view endEditing:YES];
}

-(void)keyboardWillShow:(id)sender{
    [self.view addGestureRecognizer:self.tapRecognizer];
}

-(void)keyboardWillHide:(id)sender{
    [self.view removeGestureRecognizer:self.tapRecognizer];
}




-(IGReview*)buildReview{
    IGReview *review = [[IGReview alloc] init];
    review.reviewer =  [PFUser currentUser];
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    if([[self.reviewTextView.text stringByTrimmingCharactersInSet:characterSet] length]){
        review.content = self.reviewTextView.text;
    }else {
        [self displayAlertWithTitle:@"Błąd" message:@"Pole opinia nie może być puste"];
        return nil;
    }
    review.rating = [NSNumber numberWithFloat:self.starsView.rating];
    return review;
}


-(void)displayAlertWithTitle:(NSString*)title message:(NSString*)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
