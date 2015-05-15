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
//#import "MBProgressHUD.h"

@interface PreferencesViewController () <CategorySwitcherDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) BOOL moderationMode;
@property (nonatomic) NSMutableArray *categories;
@property (nonatomic )NSMutableArray* selectedCategories;
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;
@property (strong) LoginController *loginController;
@property (weak, nonatomic) IBOutlet UILabel *greetingsLabel;

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
    
    //_categories = @[@"Park",@"Muzeum",@"Zabytek",@"Kino",@"Teatr",@"Cmentarz"];
    
    self.categories = [[NSMutableArray alloc] init];
    self.selectedCategories = [NSMutableArray array];
    self.categoriesTableView.delegate = self;
    self.categoriesTableView.dataSource = self;
    [self.categoriesTableView registerNib:[UINib nibWithNibName:@"CategorySwitcherTableCell" bundle:nil] forCellReuseIdentifier:@"CategorySwitcherCell"];
    
  //  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    PFQuery *categoriesQuery = [PFQuery queryWithClassName:@"Category"];
    [categoriesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *o in objects) {
            IGCategory *category = [IGCategory categoryWithParseObject:o];
            [self.categories addObject:category];
        }
     //   [hud hide:YES];
        [self.categoriesTableView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"DownloadedCategoryImage" object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    if (![PFUser currentUser]) {
        self.loginController = [[LoginController alloc] init];
        self.loginController.parentViewController = self;
        [self.loginController presentLoginViewController];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString: @"QueryForAttractions"]){
        
        AttractionsTableViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.preferences = [self buildPreferences];
        destinationViewController.moderationMode = self.moderationMode;
    }
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


@end
