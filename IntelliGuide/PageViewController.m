//
//  PageViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "PageViewController.h"
#import "AttractionDescriptionViewController.h"
#import "AttractionReviewsViewController.h"
#import "GalleryFetcher.h"

@interface PageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) NSArray *myViewControllers;
@property (nonatomic) NSMutableArray *galleryImages;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"lala");
    
    
    self.galleryImages = [NSMutableArray array];
    self.delegate = self;
    self.dataSource = self;
    
    AttractionDescriptionViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"AttractionDescriptionVC"];
    vc1.descriptionText = self.attraction.placeDescription;
    AttractionReviewsViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"AttractionReviewsVC"];
    vc2.attraction = self.attraction;
    
    self.myViewControllers = @[vc1, vc2];
    
    [self setViewControllers:@[vc1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
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

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
     viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.myViewControllers indexOfObject:viewController];
    // get the index of the current view controller on display
    
    if (currentIndex > 0)
    {
        return [self.myViewControllers objectAtIndex:currentIndex-1];
        // return the previous viewcontroller
    } else
    {
        return nil;
        // do nothing
    }
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.myViewControllers indexOfObject:viewController];
    // get the index of the current view controller on display
    // check if we are at the end and decide if we need to present
    // the next viewcontroller
    if (currentIndex < [self.myViewControllers count]-1)
    {
        return [self.myViewControllers objectAtIndex:currentIndex+1];
        // return the next view controller
    } else
    {
        return nil;
        // do nothing
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.myViewControllers.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end
