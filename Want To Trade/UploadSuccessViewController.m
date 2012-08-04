//
//  UploadSuccessViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UploadSuccessViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "FBConnect.h"

@interface UploadSuccessViewController ()

@end

@implementation UploadSuccessViewController

@synthesize bookView = _bookView;
@synthesize facebook = _facebook;

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
    
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    if (appDel.uploadedImage != nil) {
        [_bookView setImage:appDel.uploadedImage];
    }
    
    self.navigationItem.hidesBackButton = YES;
    
    _facebook = [[Facebook alloc] initWithAppId:@"152570318200694" andDelegate:self];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"152570318200694", @"app_id",
                                   @"http://signup.wanttotrade.me/", @"link",
                                   @"Want To Trade", @"name",
                                   @"Successful Upload.", @"caption",
                                   @"This user just added a book to Want To Trade's mobile application. Download the application to see what he wants offered", @"description",
                                   nil];
    
    [_facebook dialog:@"feed" andParams:params andDelegate:self];
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
    NSLog(@"I have prepared for segue, yet I am still useless\n");
    HomeViewController *hvc = [segue destinationViewController];
    hvc.navigationItem.hidesBackButton = YES;
}
@end
