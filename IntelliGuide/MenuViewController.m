//
//  MenuViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "MenuViewController.h"
#import "PreferencesViewController.h"
#import "AttractionsTableViewController.h"

@interface MenuViewController () {
    NSArray *menuItems;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    menuItems = @[@"preferences", @"moderationPanel", @"myAttractions", @"settings"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[menuItems objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *nav = (UINavigationController*)segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"normalPanel"]) {
        PreferencesViewController *controller = (PreferencesViewController*)nav.childViewControllers[0];
        controller.userAttractionsMode = NO;
        controller.moderationMode = NO;
        controller.navigationItem.title = @"Accepted";
    }
    
    if ([segue.identifier isEqualToString:@"moderationPanel"]) {
        PreferencesViewController *controller = (PreferencesViewController*)nav.childViewControllers[0];
        controller.userAttractionsMode = NO;
        controller.moderationMode = YES;
        controller.navigationItem.title = @"Moderator";
    }
    
    if ([segue.identifier isEqualToString:@"myAttractions"]) {
        PreferencesViewController *controller = (PreferencesViewController*)nav.childViewControllers[0];
        controller.userAttractionsMode = YES;
        controller.moderationMode = NO;
        controller.navigationItem.title = @"My Attractions";
    }
}

@end
