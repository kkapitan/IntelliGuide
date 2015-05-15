//
//  MenuViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "MenuViewController.h"
#import "PreferencesViewController.h"

@interface MenuViewController () {
    NSArray *menuItems;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    menuItems = @[@"preferences", @"moderationPanel", @"settings"];
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
    if ([segue.identifier isEqualToString:@"normalPanel"]) {
        UINavigationController *nav = (UINavigationController*)segue.destinationViewController;
        PreferencesViewController *controller = (PreferencesViewController*)nav.childViewControllers[0];
        controller.moderationMode = NO;
        controller.navigationItem.title = @"User";
    }
    
    if ([segue.identifier isEqualToString:@"moderationPanel"]) {
        UINavigationController *nav = (UINavigationController*)segue.destinationViewController;
        PreferencesViewController *controller = (PreferencesViewController*)nav.childViewControllers[0];
        controller.moderationMode = YES;
        controller.navigationItem.title = @"Moderator";
    }
}

@end
