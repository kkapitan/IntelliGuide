//
//  AttractionMenuViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "AttractionMenuViewController.h"
#import "NewReviewViewController.h"
#import "GalleryCollectionViewController.h"
#import "LoginController.h"

@interface AttractionMenuViewController () <UIAlertViewDelegate>

@property (strong) LoginController *loginController;

@end

@implementation AttractionMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if([identifier isEqualToString:@"addReviewSegue"]){
        if ([PFUser currentUser]) {
            return YES;
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Błąd" message:@"Nie jesteś zalogowany, nie możesz dodać komentarza" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Zaloguj", nil];
            [alert show];
            return NO;
        }
    } else {
        return YES;
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"addReviewSegue"]){
        NewReviewViewController *newReviewViewController = segue.destinationViewController;
        newReviewViewController.attraction = self.attraction;
    }else {
        GalleryCollectionViewController *galleryViewController = (GalleryCollectionViewController*)segue.destinationViewController;
        galleryViewController.galleryImages = self.galleryImages;
        NSLog(@"%@",self.galleryImages);
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
    } else if (buttonIndex == 1) {
        self.loginController = [[LoginController alloc] init];
        self.loginController.parentViewController = self;
        [self.loginController presentLoginViewController];
        
    }
}

@end
