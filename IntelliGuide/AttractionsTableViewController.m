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
#import "IGAttraction.h"

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
    
    NSString *categoryKey = [IGAttraction stringForKey:IGAttractionKeyCategory];
    NSString *verifiedKey = [IGAttraction stringForKey:IGAttractionKeyVerified];
    NSString *categoryNameKey = [IGCategory stringForKey:IGCategoryKeyName] ;
    
    PFQuery *categoryQuery = [PFQuery queryWithClassName:@"Category"];
    [categoryQuery whereKey:categoryNameKey containedIn:[self.preferences[@"categories"] valueForKeyPath:@"name"]];
    
    PFQuery *attractionQuery = [PFQuery queryWithClassName:@"Place"];
    [attractionQuery includeKey:categoryKey];

    [attractionQuery whereKey:categoryKey matchesQuery:categoryQuery];
    [attractionQuery whereKey:verifiedKey equalTo:[NSNumber numberWithBool:!self.moderationMode]];
    
    return attractionQuery;
};


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    static NSString *reuseIdentifier = @"AttractionCellReuseIdentifier";
    
    IGAttraction *attraction = [IGAttraction attractionWithParseObject:object];
    
    AttractionCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.attraction = attraction;
    
    return cell;
}


// Override to support conditional editing of the table view.
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return self.moderationMode;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *discardAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Odrzuć" handler:^(UITableViewRowAction *action,NSIndexPath *indexPath){
            AttractionCell *cell = (AttractionCell*)[tableView cellForRowAtIndexPath:indexPath];
            PFObject *attractionObject = [cell.attraction parseObject];
            [attractionObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(succeeded)[self loadObjects];
            }];
        }];
    
    UITableViewRowAction *acceptAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Akceptuj" handler:^(UITableViewRowAction *action,NSIndexPath *indexPath){
            AttractionCell *cell = (AttractionCell*)[tableView cellForRowAtIndexPath:indexPath];
            PFObject *attractionObject = [cell.attraction parseObject];
            attractionObject[@"verified"] = @YES;
            [attractionObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(succeeded)[self loadObjects];
            }];
        
        
        }];
    acceptAction.backgroundColor = [UIColor greenColor];
    
    return @[acceptAction,discardAction];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    AttractionCell *senderCell = (AttractionCell*)sender;
    AttractionDetailsViewController *destinationViewController = [segue destinationViewController];
    destinationViewController.attraction = senderCell.attraction;
}


@end
