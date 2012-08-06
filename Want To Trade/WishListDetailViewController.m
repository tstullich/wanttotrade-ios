//
//  WishListDetailViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WishListDetailViewController.h"
#import "WishlistViewController.h"
#import "AppDelegate.h"
#import "Book.h"

@interface WishListDetailViewController ()

@end

@implementation WishListDetailViewController

@synthesize bookImage;
@synthesize bookTitleLabel;
@synthesize bookIndex;
@synthesize authorLabel;
@synthesize priceLabel;
@synthesize ownerLabel;

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
    self.bookIndex = bookIndex;
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    Book *aBook = [[appDel wishList]objectAtIndex:bookIndex];
    bookTitleLabel.text = [aBook valueForKey:@"Title"];
    authorLabel.text = [aBook valueForKey:@"Author"];
    priceLabel.text = [aBook valueForKey:@"Price"];
    ownerLabel.text = [aBook valueForKey:@"ID"];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"BookInfoBackSegue"]) {
        WishlistViewController *wvc = [segue destinationViewController];
        wvc.navigationItem.hidesBackButton = YES;
    }
}

@end
