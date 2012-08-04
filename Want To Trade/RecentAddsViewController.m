//
//  RecentAddsViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecentAddsViewController.h"
#import "Book.h"
#import "RecentAddsCell.h"
#import "RecentAddsDetailViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"

@interface RecentAddsViewController ()

@end

@implementation RecentAddsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    NSLog(@"Recent Adds Initialized\n");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    // Return the number of rows in the section.
    return [appDel.recentAddsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    RecentAddsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecentAddsCell"];
    // Configure the cell...
    if (cell == nil) {
        cell = [[RecentAddsCell alloc] init];
        
    }
    Book *aBook = [appDel.recentAddsList objectAtIndex:indexPath.row];
    [cell setBookTitleLabel:(UILabel *)[aBook bookTitle]];
    cell.majorLabel.text = [aBook major];
    cell.priceLabel.text = [aBook price];
    cell.bookImage.image = [UIImage imageNamed:@"default pic.png"];
    
    NSLog(@"Cell Initialized\n");
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.recentAddsList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    /* RecentAddsDetailViewController *rvc = [[RecentAddsDetailViewController alloc] initWithNibName:@"RecentAddsDetailViewController" bundle:nil];
    Book *aBook = [_recentAddsList objectAtIndex:indexPath.row];
    rvc.bookTitleLabel.text = [aBook bookTitle];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:rvc animated:YES];
     */

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"RecentBackSegue"]) {
        HomeViewController *hvc = [segue destinationViewController];
        hvc.navigationItem.hidesBackButton = YES;
    }
}

@end
