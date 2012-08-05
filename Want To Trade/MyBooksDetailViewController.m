//
//  MyBooksDetailViewController.m
//  Want To Trade
//
//  Created by Sam  on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyBooksDetailViewController.h"
#import "Book.h"

@interface MyBooksDetailViewController ()

@end

@implementation MyBooksDetailViewController

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
    //self.bookImage = receivedBook.bookTitle;
    self.bookAuthorLabel.text = [receivedBook valueForKey:@"Author"];
    self.bookPriceLabel.text = [receivedBook valueForKey:@"Price"];
    self.bookEditionLablel.text = [receivedBook valueForKey:@"Edition"];
    self.bookConditionLabel.text = [receivedBook valueForKey:@"Condition"];
    self.bookTitleLabel.text = [receivedBook valueForKey:@"Title"];
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

@end
