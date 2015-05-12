//
//  AttractionDetailsViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "AttractionDetailsViewController.h"
#import "PageViewController.h"
#import "NewReviewViewController.h"

@interface AttractionDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *attractionImage;
@property (weak, nonatomic) IBOutlet UILabel *attractionName;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@end

@implementation AttractionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    jakieś pobieranie galerii musimy zrobić
//    self.attractionImage =
    
    self.attractionName.text = self.attraction.name;
    
    [self.attraction.imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (data) {
            self.attractionImage.image = [UIImage imageWithData:data];
            self.placeholderLabel.hidden = YES;
        }
    }];
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
    }else{
        PageViewController *pageViewController = (PageViewController*)[segue destinationViewController];
        pageViewController.attraction = _attraction;
    }
}
@end
