//
//  AttractionsTableViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "AttractionsTableViewController.h"
#import "AttractionDetailsViewController.h"
#import "AttractionCell.h"
#import "NewAttractionViewController.h"
#import "IGAttraction.h"
#import "MBProgressHUD.h"

@interface AttractionsTableViewController ()
@property(nonatomic,strong) NSArray *objects;
@end

@implementation AttractionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .5; //seconds
    lpgr.delegate = self;
    [self.collectionView addGestureRecognizer:lpgr];
    
    [self loadObjects];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection view data source

/*!
 This callback method is responsible for creating and configuring query which will be
 used to fetch attraction list. Here we use self.preferences to configure query
 and return it to caller.
 */
- (PFQuery *)queryForTable {
    
    NSString *categoryKey = [IGAttraction stringForKey:IGAttractionKeyCategory];
    NSString *verifiedKey = [IGAttraction stringForKey:IGAttractionKeyVerified];
    NSString *categoryNameKey = [IGCategory stringForKey:IGCategoryKeyName] ;
    
    PFQuery *categoryQuery = [PFQuery queryWithClassName:@"Category"];
    [categoryQuery whereKey:categoryNameKey containedIn:[self.preferences[@"categories"] valueForKeyPath:@"name"]];
    
    PFQuery *attractionQuery = [PFQuery queryWithClassName:@"Place"];
    [attractionQuery includeKey:categoryKey];
    
    if (_userAttarctionsMode) [attractionQuery whereKey:@"creator" equalTo:[PFUser currentUser]];
    else{
        [attractionQuery whereKey:categoryKey matchesQuery:categoryQuery];
        [attractionQuery whereKey:verifiedKey equalTo:[NSNumber numberWithBool:!self.moderationMode]];
    }
    
    return attractionQuery;
};


- (void)loadObjects{
    PFQuery *query = [self queryForTable];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.objects = objects;
        [self.collectionView reloadData];
        [hud hide:YES];
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.objects.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"AttractionCellReuseIdentifier";
    
    PFObject *object = self.objects[indexPath.row];
    IGAttraction *attraction = [IGAttraction attractionWithParseObject:object];
    
    AttractionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.attraction = attraction;
    
    return cell;
}


-(UIAlertController*)actionMenuForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    AttractionCell *cell = (AttractionCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    UIAlertController *menu = [UIAlertController alertControllerWithTitle:cell.attraction.name message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* discardAction = [UIAlertAction actionWithTitle:@"Odrzuć" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        PFObject *attractionObject = [cell.attraction parseObject];
        [attractionObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded)[self loadObjects];
        }];

    }];
    
    UIAlertAction* acceptAction = [UIAlertAction actionWithTitle:@"Akceptuj" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        PFObject *attractionObject = [cell.attraction parseObject];
        attractionObject[@"verified"] = @YES;
        [attractionObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded)[self loadObjects];
        }];
    }];
    
    UIAlertAction* editAction = [UIAlertAction actionWithTitle:@"Edytuj" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self performSegueWithIdentifier:@"editAttractionSegue" sender:cell];
    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Anuluj" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];

    if(self.moderationMode){
        [menu addAction:acceptAction];
        [menu addAction:discardAction];
    }else{
        [menu addAction:editAction];
    }
    [menu addAction:cancelAction];
    return menu;
};

-(void)presentActionMenuForRowAtIndexPath:(NSIndexPath*)indexPath{
    if([self canEditRowAtIndexPath:indexPath]){
        UIAlertController *menu = [self actionMenuForRowAtIndexPath:indexPath];
        [self presentViewController:menu animated:YES completion:nil];
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)gestureRecognizer{
    
    if(gestureRecognizer.state != UIGestureRecognizerStateBegan)return;
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    if(indexPath){
        [self presentActionMenuForRowAtIndexPath:indexPath];
    }
}

/*!
 Tells view controller whether it should enable swiping on cell to reveal accept/reject buttons.
 */

-(BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.

    PFObject *currentObject = [self.objects objectAtIndex:indexPath.row];
    IGAttraction *currentAttraction = [IGAttraction attractionWithParseObject:currentObject];
    if (self.moderationMode) return YES;
    else if ([[PFUser currentUser].objectId isEqualToString:currentAttraction.creator.objectId])return YES;
    return NO;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"editAttractionSegue"]){
        NewAttractionViewController *newAttractionViewController = segue.destinationViewController;
        AttractionCell *cell = (AttractionCell*)sender;
        newAttractionViewController.toEdit = cell.attraction;
    }else{
        AttractionCell *senderCell = (AttractionCell*)sender;
        AttractionDetailsViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.attraction = senderCell.attraction;
    }
}

@end
