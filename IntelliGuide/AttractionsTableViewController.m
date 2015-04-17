//
//  AttractionsTableViewController.m
//  IntelliGuide
//
//  Created by Krzysztof Kapitan on 16.04.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "AttractionsTableViewController.h"
#import "Attraction.h"

@interface AttractionsTableViewController ()

@end

@implementation AttractionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.parseClassName = @"Place";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (PFQuery *)queryForTable {
    
    PFQuery *categoryQuery = [PFQuery queryWithClassName:@"Category"];
    [categoryQuery whereKey:@"nazwa" containedIn:self.preferences[@"categories"]];
    
    PFQuery *attractionQuery = [PFQuery queryWithClassName:@"Place"];
    [attractionQuery includeKey:@"category"];
    [attractionQuery whereKey:@"category" matchesQuery:categoryQuery];
    
    return attractionQuery;
};


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    static NSString *reuseIdentifier = @"AttractionCellReuseIdentifier";
    
    Attraction *attraction = [Attraction attractionWithParseObject:object];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text = attraction.name;
    cell.detailTextLabel.text = attraction.categoryName;//attraction.categoryName;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
