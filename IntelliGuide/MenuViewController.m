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
#import "LoginController.h"

@interface MenuViewController () <UIAlertViewDelegate> {
    NSArray *menuItems;
    NSArray *userMenuItems;
    NSArray *redactorMenuItems;
    NSArray *moderatorMenuItems;
    NSArray *headerTitles;

}

@property (strong) LoginController *loginController;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userMenuItems = @[@"preferences",@"settings"];
    redactorMenuItems = @[@"myAttractions"];
    moderatorMenuItems = @[@"moderationPanel"];
    headerTitles = @[@"Użytkownik",@"Redaktor",@"Moderator"];
    menuItems = @[userMenuItems,redactorMenuItems,moderatorMenuItems];
    
    self.tableView.alwaysBounceVertical = NO;
    //self.tableView.dataSource = nil;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return headerTitles[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[menuItems[indexPath.section] objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray*)(menuItems[section]) count];
}


-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 0.5, view.frame.size.width, 1)];
    UIView *separator2 = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 1.0, view.frame.size.width, 1)];
    separator.backgroundColor = [UIColor darkGrayColor];
    separator2.backgroundColor = [UIColor blackColor];
    [view addSubview:separator];
    [view addSubview:separator2];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([PFUser currentUser]){
        return menuItems.count;
    }
    else return 1;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"normalPanel"]) {
        return YES;
    } else if ([identifier isEqualToString:@"moderationPanel"]) {
        if ([PFUser currentUser]) {
            if ([[[PFUser currentUser] objectForKey:@"role"] isEqualToString:@"moderator"]) {
                return YES;
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Błąd" message:@"Nie jesteś moderatorem, nie masz dostępu do tej strony" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return NO;
            }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Błąd" message:@"Nie jesteś zalogowany, nie możesz przejść do tej strony" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Zaloguj", nil];
            [alert show];
            return NO;
        }
    } else if ([identifier isEqualToString:@"myAttractions"]) {
        if ([PFUser currentUser]) {
            return YES;
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Błąd" message:@"Nie jesteś zalogowany, nie możesz przejść do tej strony" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Zaloguj", nil];
            [alert show];
            return NO;
        }
    } else {
        return YES;
    }
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
