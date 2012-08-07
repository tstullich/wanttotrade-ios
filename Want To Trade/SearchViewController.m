//
//  SearchViewController.m
//  Want To Trade
//
//  Created by Sam  on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "Book.h"
#import "SearchCell.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#import "HomeViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize searchList;
@synthesize selectedIndex;
@synthesize responseString;
@synthesize receivedData;

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
    
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    
    if (cell == nil) {
        cell = [[SearchCell alloc] init];
    }
    
    // Configure the cell...
    cell.titleLabel.text = [[searchList objectAtIndex:indexPath.row] valueForKey:@"Title"];
    cell.authorLabel.text = [[searchList objectAtIndex:indexPath.row] valueForKey:@"Author"];
    cell.priceLabel.text = [[searchList objectAtIndex:indexPath.row] valueForKey:@"Price"];
    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    selectedIndex = indexPath.row;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Searching...";
    
    searchBar.text = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString *url = [[NSString alloc] initWithFormat:@"https://cloud.skypaz.com/soa/pipes/http?bsuser=wtt.com-skypaz-FindBooks&bspass=wtt2012&Keyword=%@", searchBar.text]; 
    
    NSURLRequest *theRequest = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
    
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    if (theConnection) {
        receivedData = [NSMutableData data];
    }
    [searchBar setText:@""];
    
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

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    
    //Receives a response after book has been uploaded (Preferably a Book ID...)
    responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response String: %@", responseString);
    
    NSDictionary *results = [responseString JSONValue];
    
    searchList = [results objectForKey:@"data"];
    
    for (Book *book in searchList) {
        NSLog(@"Title: %@\n", [book valueForKey:@"Title"]);
    }
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
}

//Uses the loaded json and adds the books to the view.
//Also dismisses the progress view
-(void)updateUI{
    if ([searchList count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"No Books Matching Your Search Were Found.\nPlease Try Another Search." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self.tableView reloadData];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"CancelSearchSegue"]){
        HomeViewController *hvc = [segue destinationViewController];
        hvc.navigationItem.hidesBackButton = YES;
    }
}

@end
