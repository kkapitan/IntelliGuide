//
//  PreferencesViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "PreferencesViewController.h"
#import "AttractionsTableViewController.h"
//#import "CategorySwitcherView.h"
#import "CategorySwitcherTableCell.h"

@interface PreferencesViewController () <CategorySwitcherDelegate, UITableViewDelegate, UITableViewDataSource>

@property NSArray *categories;
@property NSMutableArray* selectedCategories;
@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;

- (IBAction)didToggleCustomLocation:(id)sender;

@end

@implementation PreferencesViewController

#pragma mark Switches

-(void)didEnableCategory:(NSString *)category{
    [self.selectedCategories addObject:category];
}

-(void)didDisableCategory:(NSString *)category{
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
    
    _categories = @[@"Park",@"Muzeum",@"Zabytek",@"Kino",@"Teatr",@"Cmentarz"];
    
    self.selectedCategories = [NSMutableArray array];
    self.categoriesTableView.delegate = self;
    self.categoriesTableView.dataSource = self;
    [self.categoriesTableView registerNib:[UINib nibWithNibName:@"CategorySwitcherTableCell" bundle:nil] forCellReuseIdentifier:@"CategorySwitcherCell"];
    
//    int i = 0;
//    for(UIView* view in [self.view subviews]){
//        if([view.class isSubclassOfClass:[CategorySwitcherView class]]){
//            CategorySwitcherView* categorySwitcherView = (CategorySwitcherView*)view;
//            categorySwitcherView.delegate = self;
//            categorySwitcherView.categoryName = _categories[i++];
//        }
//    }
    
    // Do any additional setup after loading the view.
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
    
    cell.categoryName = _categories[indexPath.row];
    cell.delegate = self;
    
    return cell;
    
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
