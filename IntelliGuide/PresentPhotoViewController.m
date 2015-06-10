//
//  PresentPhotoViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 19.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "PresentPhotoViewController.h"
#import "NavigationControllerDelegate.h"
@interface PresentPhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PresentPhotoViewController
- (void)downSwipe:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)leftSwipe:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightSwipe:(id)sender {
    
    if(self.images.count == self.number + 1)return;
    
//    NSLog(@"%d",self.number);
    PresentPhotoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoController"];
    vc.number = self.number + 1;
    vc.images = self.images;
    
    if(vc.number % 2){
        vc.view.backgroundColor = [UIColor blackColor];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipe:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    [self.view addGestureRecognizer:downSwipe];
    
//    NSLog(@"%@",self.images);
    
    self.imageView.image = self.images[self.number];
    // Do any additional setup after loading the view.
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

@end
