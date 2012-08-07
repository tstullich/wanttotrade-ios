//
//  WishListSearchViewController.m
//  Want To Trade
//
//  Created by Sam  on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WishListSearchViewController.h"
#import "WishlistViewController.h"
#import "WishListSearchCell.h"
#import "SearchDetailViewController.h"
#import "MBProgressHUD.h"
#import "Book.h"
#import "JSON.h"


@interface WishListSearchViewController ()

@end

@implementation WishListSearchViewController
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
    self.searchList = [[NSMutableArray alloc] init];
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
    if ([searchList count] == 0) {
        return 0;
    }
    else {
        return [searchList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WishListSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WishListSearchCell"];
    if (cell == nil) {
        cell = [[WishListSearchCell alloc] init];
    }
    // Configure the cell...
    cell.titleLabel.text = [[searchList objectAtIndex:indexPath.row] valueForKey:@"Title"];
    cell.majorLabel.text = [[searchList objectAtIndex:indexPath.row] valueForKey:@"Major"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"SearchDetailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"CancelSearchSegue"]){
        WishlistViewController *wvc = [segue destinationViewController];
        wvc.navigationItem.hidesBackButton = YES;
    }
    else if ([[segue identifier] isEqualToString:@"SearchDetailSegue"]) {
        SearchDetailViewController *svc = [segue destinationViewController];
        svc.receivedBook = [searchList objectAtIndex:selectedIndex];
        
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    /*UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonItemStylePlain target:self 
                                              action:@selector(doneSearch_Clicked:)];
    rightButton.title = @"Search";*/
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Search Began");
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
    if (searchList.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Books Matching Books Were Found.\n Please Try Some Different Input." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [searchList removeAllObjects]; 
    }
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
