//
//  ProfileViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileEditViewController.h"
#import "AppDelegate.h"
#import "NSDataAdditions.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize nameLabel = _nameLabel;
@synthesize emailLabel = _emailLabel;
@synthesize schooLabel = _schooLabel;
@synthesize majorLabel = _majorLabel;
@synthesize profilePhoto = _profilePhoto;

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
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDel.userPhoto != nil) {
        [_profilePhoto setImage:appDel.userPhoto];
    }
    if (appDel.userName != nil)
    {
        [_nameLabel setText:appDel.userName];
    }
    if (appDel.userEmail != nil) {
        [_emailLabel setText:appDel.userEmail];
    }
    if (appDel.userSchool != nil){
        [_schooLabel setText:appDel.userSchool];
    }
    if (appDel.userMajor != nil){
        [_majorLabel setText:appDel.userMajor];
    }
    
    NSString *encodedImg = [self readStringFromFile];
    NSLog(@"Encoded Img: %@", encodedImg);
    NSData *decodedImg = [NSData base64DataFromString:encodedImg];
    NSLog(@"Decoded Img: %@", decodedImg);
    UIImage *userImg = [[UIImage alloc] initWithData:decodedImg];
    NSLog(@"User Img: %@", userImg);
    
    _profilePhoto.image = userImg;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
    if ([defaults boolForKey:@"UsedFBLogin"]) {
        UIBarButtonItem *fbLogout =[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(someMethod)];
        [fbLogout setTintColor:[UIColor redColor]];
        self.navigationItem.leftBarButtonItem = fbLogout;
        
    }
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Loading screen background.png"]];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    if (appDel.userID == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Please create an account or log in to fully utilize this feature" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ProfileEditSegue"]){
        NSLog(@"Edit Segue\n");
    }
}

-(void)someMethod{
    NSLog(@"Logout Code To Come Here");
#warning Tim, come back to this!!
    NSLog(@"This will test the changes made");
}

- (NSString*)readStringFromFile {
    
    // Build the path...
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"test.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    // The main act...
    return [[NSString alloc] initWithData:[[NSData alloc] initWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}

@end
