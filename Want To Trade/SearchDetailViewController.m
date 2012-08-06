//
//  SearchDetailViewController.m
//  Want To Trade
//
//  Created by Sam  on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "AppDelegate.h"

@interface SearchDetailViewController ()

@end

@implementation SearchDetailViewController

@synthesize bookImage;
@synthesize bookAuthorLabel;
@synthesize bookTitleLabel;
@synthesize bookPriceLabel;
@synthesize bookEditionLablel;
@synthesize bookConditionLabel;
@synthesize receivedBook;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.bookAuthorLabel.text = [receivedBook valueForKey:@"Author"];
    self.bookPriceLabel.text = [receivedBook valueForKey:@"Price"];
    self.bookEditionLablel.text = [receivedBook valueForKey:@"Edition"];
    self.bookConditionLabel.text = [receivedBook valueForKey:@"Condition"];
    self.bookTitleLabel.text = [receivedBook valueForKey:@"Title"];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBook)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)addBook{
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    NSInteger count = [appDel.wishList count];
    [appDel.wishList addObject:receivedBook];
    if (count < [appDel.wishList count]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"This Book has been added to your Wish List." 
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Unable to add the book." 
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

@end
