//
//  AttractionReviewsViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 19.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "AttractionReviewsViewController.h"
#import "NewReviewViewController.h"
#import "ReviewCell.h"

@interface AttractionReviewsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *plusImageView;

@end

@implementation AttractionReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(newReview:)];
    [self.plusImageView setUserInteractionEnabled:YES];
    [self.plusImageView addGestureRecognizer:tapRecognizer];
    self.parseClassName = @"Review";
}

-(void)newReview:(id)sender{
    [self performSegueWithIdentifier:@"addReviewSegue" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (PFQuery *)queryForTable {
    
    PFQuery *reviewsQuery = [PFQuery queryWithClassName:@"Review"];
    PFObject *object = [PFObject objectWithClassName:@"Place"];
    object.objectId = self.attraction.objectId;
    [reviewsQuery whereKey:@"aboutPlace" equalTo:object];
    [reviewsQuery includeKey:@"writtenBy"];
    
    return reviewsQuery;
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    static NSString *reuseIdentifier = @"ReviewCell";
    
    //Attraction *attraction = [Attraction attractionWithParseObject:object];
    
    ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    IGReview *review = [IGReview reviewWithParseObject:object];
    // Configure the cell...
    cell.review = review;
    
    NSLog(@"%f",cell.frame.size.height);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*This needs to be improved. Calculating size based on content is much better than doing it by
    dequeuing cell*/
    
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
    IGReview *review = [IGReview reviewWithParseObject:object];
    NSString *reviewContent = review.content;
    
    static ReviewCell* cell;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCell"];
    });
    
    UILabel *label = (UILabel*)[cell viewWithTag:10];
    
    CGRect rect = [reviewContent boundingRectWithSize:CGSizeMake(label.frame.size.width, 500) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil];
    
    return 50 + rect.size.height;
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"addReviewSegue"]){
        NewReviewViewController *newReviewViewController = segue.destinationViewController;
        newReviewViewController.attraction = self.attraction;
    }
}


@end
