//
//  MyBooksViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyBooksViewController.h"
#import "Book.h"
#import "MyBooksCell.h"
#import "HomeViewController.h"
#import "SBJson.h"
#import "MBProgressHUD.h"
#import "MyBooksDetailViewController.h"

@interface MyBooksViewController ()

@end

@implementation MyBooksViewController

@synthesize selectedIndex = _selectedIndex;
@synthesize appDel = _appDel;
@synthesize receivedData;
@synthesize responseString;
@synthesize books = _books;

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
    _appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self getBooks];
    });
        
}

//If an account hasn't been created, a small error message will pop up
-(void)viewDidAppear:(BOOL)animated{
    if (_appDel.userID == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You need to create an account first or log in to use this feature" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [self performSegueWithIdentifier:@"UploadCancelSegue" sender:self];
    }
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
    
    // Return the number of rows in the section.
    return [_books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBooksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBooksCell"];
    if(cell == nil){
        cell = [[MyBooksCell alloc] init];
    }
    
    // Configure the cell..
    NSLog(@"Book at Index: %i\n", indexPath.row);
    
    cell.bookTitleLabel.text = [[_books objectAtIndex:indexPath.row] valueForKey:@"Title"];
    cell.offersLabel.text = [[_books objectAtIndex:indexPath.row] valueForKey:@"Price"] ;
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_books removeObjectAtIndex:indexPath.row];
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
    _selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"MyBooksDetailSegue" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"MyBooksBackSegue"]) {
        HomeViewController *hvc = [segue destinationViewController];
        hvc.navigationItem.hidesBackButton = YES;
    }
    else if ([[segue identifier] isEqualToString:@"MyBooksDetailSegue"]) {
        MyBooksDetailViewController *bdv = [segue destinationViewController];
        
        bdv.receivedBook = [_books objectAtIndex:_selectedIndex];
    }
}

-(void)getBooks{
    
    NSMutableString *theURL = [[NSMutableString alloc] initWithString:@"https://cloud.skypaz.com/soa/pipes/http?bsuser=wtt.com-skypaz-ListUserBooks&bspass=wtt2012"];
    
    [theURL appendFormat:@"&UserID=%@", _appDel.userID];
    
    NSLog(@"%@\n", theURL);
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:theURL]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:10.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data];
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

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    
    //Receives a response after book has been uploaded (Preferably a Book ID...)
    responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response String: %@", responseString);
    
    NSDictionary *results = [responseString JSONValue];
    
    _books = [results objectForKey:@"data"];
    
    for (Book *book in _books) {
        NSLog(@"Title: %@\n", [book valueForKey:@"Title"]);
    }
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
}

//Uses the loaded json and adds the books to the view.
//Also dismisses the progress view
-(void)updateUI{
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


@end
