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

@interface PreferencesViewController () <CategorySwitcherDelegate, UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *categories;
@property NSMutableArray* selectedCategories;
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;

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

#pragma mark Lifecycle callbacks

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_categories = @[@"Park",@"Muzeum",@"Zabytek",@"Kino",@"Teatr",@"Cmentarz"];
    
    self.categories = [[NSMutableArray alloc] init];
    self.selectedCategories = [NSMutableArray array];
    self.categoriesTableView.delegate = self;
    self.categoriesTableView.dataSource = self;
    [self.categoriesTableView registerNib:[UINib nibWithNibName:@"CategorySwitcherTableCell" bundle:nil] forCellReuseIdentifier:@"CategorySwitcherCell"];
    
    PFQuery *categoriesQuery = [PFQuery queryWithClassName:@"Category"];
    [categoriesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *o in objects) {
            IGCategory *category = [IGCategory categoryWithParseObject:o];
            [self.categories addObject:category];
        }
        [self.categoriesTableView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"DownloadedCategoryImage" object:nil];
    
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
    }
}

@end
