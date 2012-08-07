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
#import "MBProgressHUD.h"
#import "JSON.h"

@interface RecentAddsViewController ()

@end

@implementation RecentAddsViewController

@synthesize receivedData;
@synthesize responseString;
@synthesize searchList;
@synthesize selectedIndex;


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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    NSURLRequest *theRequest = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"https://cloud.skypaz.com/soa/pipes/http?bsuser=wtt.com-skypaz-GetRecentAdditions&bspass=wtt2012"]];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection) {
        receivedData = [NSMutableData data];
    }
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
    // Return the number of rows in the section.
    return [searchList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RecentAddsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecentAddsCell"];
    // Configure the cell...
    if (cell == nil) {
        cell = [[RecentAddsCell alloc] init];
        
    }
    Book *aBook = [searchList objectAtIndex:indexPath.row];
    cell.bookTitleLabel.text = [aBook valueForKey:@"Title"];
    cell.majorLabel.text = [aBook valueForKey:@"Author"];
    cell.priceLabel.text = [aBook valueForKey:@"Price"];
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

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error
{
    // release the connection, and the data object
    // inform the user
    UIAlertView* netAlert = [[UIAlertView alloc] initWithTitle:@"Whoops..." message:@"Connection Failed!\n Please make sure you have an internet connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [netAlert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response: %@", responseString);
    
    NSDictionary *result = [responseString JSONValue];
    
    searchList = [result objectForKey:@"data"];
    
    [self performSelector:@selector(updateUI)];
}

-(void)updateUI{
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
