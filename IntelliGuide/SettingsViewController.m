//
//  SettingsViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 15.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "SettingsViewController.h"
#import "SWRevealViewController.h"
#import "LoginController.h"
#import <Parse/Parse.h>

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong) LoginController *loginController;

@property NSArray *sectionTitles;
    
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sectionTitles = @[@"User options"];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoggingIn) name:@"loggedInSuccessfully" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoggingIn) name:@"signedUpSuccessfully" object:nil];
}

//TODO trzeba się jakoś wypisywać, ale w taki sposób, żeby odebrać notyfikację od loginControllera
//- (void)viewDidDisappear:(BOOL)animated {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logInCell"];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([PFUser currentUser]) {
                cell.textLabel.text = [NSString stringWithFormat:@"Log out (%@)", [[PFUser currentUser] username]];
            } else {
                cell.textLabel.text = @"Log in";
            }
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([PFUser currentUser]) {
                [PFUser logOut];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"You've been succesfully logged out" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [self.tableView reloadData];
            } else {
                self.loginController = [[LoginController alloc] init];
                self.loginController.parentViewController = self;
                [self.loginController presentLoginViewController];
            }
        }
    }
}

- (void) didFinishLoggingIn {
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
