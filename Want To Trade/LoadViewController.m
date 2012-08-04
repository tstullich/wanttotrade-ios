//
//  LoadViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoadViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SignUpViewController.h"

@interface LoadViewController (){
}
@end

@implementation LoadViewController

@synthesize status;
@synthesize firstTime;
@synthesize activityIndicator = _activityIndicator;

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
    //int i = 0;
    [_activityIndicator startAnimating];
    
}

-(void)viewDidAppear:(BOOL)animated{
    firstTime = YES;
    int i = 0;
    BOOL Done = NO;
    
    if (firstTime) {
        status.text = @"Performing First Time Setup...";
    } else {
        status.text = @"Checking For New Content...";
    }
    while (!Done && i != 5000) 
    {
        NSLog(@"Count is %i\n", i);
        i++;
     if (i == 5000) {
         Done = YES;
     }
     }
     [_activityIndicator stopAnimating];
     NSLog(@"Finished\n");
    [self performSegueWithIdentifier:@"LoadToHomeSegue" sender:self];
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
    if ([[segue identifier] isEqualToString:@"LoadToHomeSegue"]) {
        HomeViewController *hvc = [segue destinationViewController];
    }
    else if (firstTime) {
        SignUpViewController *svc = [segue destinationViewController];
    }
}
@end
