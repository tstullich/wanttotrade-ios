//
//  WishlistViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WishlistViewController.h"
#import "Book.h"
#import "WishListCell.h"
#import "WishListDetailViewController.h"
#import "AppDelegate.h"
#import "SearchViewController.h"

@interface WishlistViewController ()

@end

@implementation WishlistViewController

@synthesize selectedIndex = _selectedIndex;

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
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    
    // Return the number of rows in the section.
    return [appDel.wishList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WishListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WishListCell"];
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    
    
    if (cell == nil){
        cell = [[WishListCell alloc] init];
    }
    
    cell.bookTitleLabel.text = [[appDel.wishList objectAtIndex:indexPath.row] valueForKey:@"Title"];
    cell.majorLabel.text = [[appDel.wishList objectAtIndex:indexPath.row] valueForKey:@"Major"];
    cell.priceLabel.text = [[appDel.wishList objectAtIndex:indexPath.row] valueForKey:@"Price"];
    
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [appDel.wishList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    
    // ...
     // Pass the selected object to the new view controller.
     //[self.navigationController pushViewController:detailViewController animated:YES];
     */
    _selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"WishListDetailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"SearchBooksSegue"]) {
        
    }
    else if ([[segue identifier] isEqualToString:@"WishListDetailSegue"]) {
        WishListDetailViewController *wvc = [segue destinationViewController];
        wvc.bookIndex = _selectedIndex;
    }
}

@end
