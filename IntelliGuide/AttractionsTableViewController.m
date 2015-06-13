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


@interface AttractionsTableViewController () <UICollectionViewDelegateFlowLayout,UISearchBarDelegate, EndEditingProtocol>
@property(nonatomic,strong) NSArray *objects;
@property(nonatomic,strong) NSArray *originalObjects;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic) BOOL searchMode;
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UIBarButtonItem *searchBarButton;
@property(nonatomic,strong) UIBarButtonItem *searchBarView;
@property(nonatomic,strong) UIView *searchBarContainer;
@property(nonatomic,strong) UITapGestureRecognizer *tapRecognizer;

@end

@implementation AttractionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Long press recognizer
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .5; //seconds
    lpgr.delegate = self;
    [self.collectionView addGestureRecognizer:lpgr];
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBarLoseFocus)];
   
    
    // Refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshingAction) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
    
    
    //SearchBarButton
    self.searchBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonOn:)];
    self.navigationItem.rightBarButtonItem = self.searchBarButton;
    
    //SearchBar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width/1.25, 40)]; //At the begining move it out of screen
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Wyszukaj po nazwie...";
    self.searchBar.showsCancelButton = YES;
    self.searchBar.backgroundImage = [[UIImage alloc] init]; // Clear the background color
    
    //SearchBarContainer
    self.searchBarContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.25, 40)];
    self.searchBarContainer.backgroundColor = [UIColor clearColor];
    [self.searchBarContainer addSubview:self.searchBar];
    
    self.searchBarView = [[UIBarButtonItem alloc] initWithCustomView:self.searchBarContainer];

    NSLog(@"%@", self.searchCenter);
    
    [self loadObjects];
}

- (void)didEndEditingAttraction {
    //TODO to mogłoby modyfikować tylko jeden wpis z całej tablicy zamiast pobierać wszystko od nowa
    [self loadObjects];
}

#pragma mark - SearchBar

- (void)searchButtonOn:(id)sender {
    
    self.navigationItem.rightBarButtonItem = self.searchBarView;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:0 animations:^{
           self.searchBar.frame = CGRectOffset(self.searchBar.frame, -self.view.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self.searchBar becomeFirstResponder];
    }];
    
    /*
    self.navigationItem.rightBarButtonItem = self.searchBarView;
    [UIView animateWithDuration:1 animations:^{
        self.searchBar.frame = CGRectOffset(self.searchBar.frame, -self.view.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self.searchBar becomeFirstResponder];
    }];
    */
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.searchBar.frame = CGRectOffset(self.searchBar.frame, self.view.frame.size.width, 0);
    } completion:^(BOOL finished) {
        self.navigationItem.rightBarButtonItem = self.searchBarButton;
        self.searchBar.text = @"";
        [self.searchBar.delegate searchBar:searchBar textDidChange:self.searchBar.text];
    }];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(!self.originalObjects)return;
    
    if([searchText isEqualToString:@""]){
        self.objects = self.originalObjects;
    }else{
        [self filterObjectsWithName:searchText];
    }
    [self.collectionView reloadData];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
     [self.collectionView addGestureRecognizer:self.tapRecognizer];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.collectionView removeGestureRecognizer:self.tapRecognizer];
}

-(void)searchBarLoseFocus{
    [self.searchBar endEditing:YES];
}

-(void)filterObjectsWithName:(NSString*)name{
    NSMutableArray *results = [NSMutableArray array];
    for(PFObject *object in self.originalObjects){
        if([object[@"name"] containsString:name])
            [results addObject:object];
    }
    self.objects = results;
}

#pragma mark - RefreshControl

-(void)refreshingAction{
    [self loadObjects];
    [self.refreshControl endRefreshing];
    
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
    else {
        [attractionQuery whereKey:categoryKey matchesQuery:categoryQuery];
        [attractionQuery whereKey:verifiedKey equalTo:[NSNumber numberWithBool:!self.moderationMode]];
    }
    
    if (_searchCenter) {
        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLocation:_searchCenter];
        [attractionQuery whereKey:[IGAttraction stringForKey:IGAttractionKeyLocation] nearGeoPoint:geoPoint withinKilometers:20];
    }
    
    return attractionQuery;
};


- (void)loadObjects{
    PFQuery *query = [self queryForTable];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.objects = objects;
        self.originalObjects = [objects copy];
        [self.collectionView reloadData];
        [hud hide:YES];
    }];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width - 10, 60);
};

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
    
    UIAlertController *menu = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
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
        newAttractionViewController.delegate = self;
    }else{
        AttractionCell *senderCell = (AttractionCell*)sender;
        AttractionDetailsViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.attraction = senderCell.attraction;
    }
}

@end
