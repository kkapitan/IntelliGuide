//
//  AttractionDetailsViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "AttractionDetailsViewController.h"
#import "PageViewController.h"

@interface AttractionDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *attractionImage;
@property (weak, nonatomic) IBOutlet UILabel *attractionName;

@end

@implementation AttractionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    jakieś pobieranie galerii musimy zrobić
//    self.attractionImage =
    
    self.attractionName.text = self.attraction.name;
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
    PageViewController *pageViewController = (PageViewController*)[segue destinationViewController];
    pageViewController.attraction = _attraction;
//    NSLog(@"%@", pageViewController.myViewControllers);
//    NSLog(@"%@ to: %@", sender, [segue destinationViewController]);
}

@end
