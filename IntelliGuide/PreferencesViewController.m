//
//  PreferencesViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "PreferencesViewController.h"
#import "AttractionsTableViewController.h"
#import "CategorySwitcherTableCell.h"
#import "IGCategory.h"
#import "LoginController.h"
#import "SWRevealViewController.h"
#import "MBProgressHUD.h"
#import "NewAttractionViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PreferencesViewController () <CategorySwitcherDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic) BOOL didShowLogin;
@property (nonatomic) NSMutableArray *categories;
@property (nonatomic )NSMutableArray* selectedCategories;
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@property (strong) LoginController *loginController;
@property (weak, nonatomic) IBOutlet UILabel *greetingsLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)didToggleCustomLocation:(id)sender;

@end

@implementation PreferencesViewController

#pragma mark Switches

- (void) didEnableCategory:(IGCategory *)category {
    [self.selectedCategories addObject:category];
}

- (void)didDisableCategory:(IGCategory *)category {
    [self.selectedCategories removeObjectIdenticalTo:category];
}

- (IBAction)didToggleCustomLocation:(id)sender {
    UISwitch *locationSwitch = (UISwitch*)sender;
    if (locationSwitch.isOn) {
        NSLog(@"My location");
    } else {
        NSLog(@"Custom location");
    }
}


- (void)selectAllCategories:(BOOL)selected{
    self.selectedCategories = selected ? self.categories : [NSMutableArray array];
    for(CategorySwitcherTableCell* cell in [self.categoriesTableView visibleCells]){
        [cell.switchControl setOn:selected animated:YES];
    }
}

- (IBAction)didSwitchMode:(id)sender {
    UIBarButtonItem* barButton = (UIBarButtonItem*)sender;
    if(self.moderationMode){
        self.moderationMode = NO;
        barButton.title = @"Tryb moderacji";
    }else{
        barButton.title = @"Tryb użytkownika";
        self.moderationMode = YES;
    }
}

#pragma mark Lifecycle callbacks

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.didShowLogin = NO;
    self.categories = [[NSMutableArray alloc] init];
    self.selectedCategories = [NSMutableArray array];
    self.categoriesTableView.delegate = self;
    self.categoriesTableView.dataSource = self;
    [self.categoriesTableView registerNib:[UINib nibWithNibName:@"CategorySwitcherTableCell" bundle:nil] forCellReuseIdentifier:@"CategorySwitcherCell"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    PFQuery *categoriesQuery = [PFQuery queryWithClassName:@"Category"];
    [categoriesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *o in objects) {
            IGCategory *category = [IGCategory categoryWithParseObject:o];
            [self.categories addObject:category];
        }
        [hud hide:YES];
        [self.categoriesTableView reloadData];
    }];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"DownloadedCategoryImage" object:nil];
    
    
   
    
    //self.view.backgroundColor = [UIColor clearColor];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.alpha = 0.8;
    self.categoriesTableView.layer.cornerRadius = 10;
    
    if (![PFUser currentUser]) {
//        if (!_didShowLogin) {
//            _didShowLogin = YES;
//            self.loginController = [[LoginController alloc] init];
//            self.loginController.parentViewController = self;
//            [self.loginController presentLoginViewController];
//        }
        self.greetingsLabel.text = @"Witaj, gościu! Co chcesz\ndzisiaj zwiedzić?";
    } else {
        self.greetingsLabel.text = [NSString stringWithFormat:@"Witaj %@, co chcesz\ndzisiaj zwiedzić?", [[PFUser currentUser] objectForKey:@"username"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary*)buildPreferences{
    NSDictionary* preferences = @{@"categories":self.selectedCategories};
    return preferences;
}

#pragma mark TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategorySwitcherTableCell *cell = [self.categoriesTableView dequeueReusableCellWithIdentifier:@"CategorySwitcherCell"];
    
    IGCategory *category = _categories[indexPath.row];
    cell.delegate = self;
    cell.category = category;
    if ([self.selectedCategories containsObject:cell.category]) [cell.switchControl setOn:YES];
    else [cell.switchControl setOn:NO];
    
    return cell;
    
}

- (void) reloadTable {
    [self.categoriesTableView reloadData];
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"newAttractionSegue"]) {
        if ([PFUser currentUser]) {
            return YES;
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Błąd" message:@"Musisz być zalogowany, żeby dodać nową atrakcję" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Zaloguj", nil];
            [alert show];
            return NO;
        }
    } else {
        return YES;
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString: @"QueryForAttractions"]){
        AttractionsTableViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.preferences = [self buildPreferences];
        destinationViewController.moderationMode = self.moderationMode;
        destinationViewController.userAttarctionsMode = self.userAttractionsMode;
    }
    
    
//        NewAttractionViewController *destinationViewController = [segue destinationViewController];
//        destinationViewController.preferences = [self buildPreferences];
//        destinationViewController.moderationMode = NO;
//        destinationViewController.userAttarctionsMode = YES;
    
}

//Cell animation

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CATransform3D scale = CATransform3DMakeScale(0.75, 0.75, 0.75);
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = scale;
    
    
    [UIView beginAnimations:@"scale" context:NULL];
    [UIView setAnimationDuration:0.4];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //        NSLog(@"OK");
    } else if (buttonIndex == 1) {
        //        NSLog(@"Zaloguj");
        self.loginController = [[LoginController alloc] init];
        self.loginController.parentViewController = self;
        [self.loginController presentLoginViewController];
        
    }
}


@end
