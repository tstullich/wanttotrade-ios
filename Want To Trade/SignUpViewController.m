//
//  SignUpViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignUpViewController.h"
#import "HomeViewController.h"
#import "SignUp2ViewController.h"
#import "FBConnect.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize emailField;
@synthesize pwField;
@synthesize facebook;
@synthesize fbLoginButton;

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
    emailField.returnKeyType = UIReturnKeyDone;
    emailField.keyboardType = UIKeyboardTypeEmailAddress;
    pwField.returnKeyType = UIReturnKeyDone;
    pwField.keyboardType = UIKeyboardTypeDefault;
    
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
    if ([[segue identifier] isEqualToString:@"SignUpCancelSegue"]) {
        NSLog(@"WTF^2");
        HomeViewController *hvc = [segue destinationViewController];
        hvc.navigationItem.hidesBackButton = YES;
    }
    else if ([[segue identifier] isEqualToString:@"SignUpDoneSegue"]) {
        
    }
    else if ([[segue identifier] isEqualToString:@"LoginToSignUpSegue"]) {
        
    }
}

//Dismisses Keyboard when anything but the text field is touched
- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}

// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"4.2 URL Support");
    return [facebook handleOpenURL:url]; 
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"Handle URL");
    return [facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    NSLog(@"Did login token: %@", [defaults valueForKey:@"FBAccessTokenKey"]);
    [defaults synchronize];
    
}

-(void)fbSignin:(id)sender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    facebook = [[Facebook alloc] initWithAppId:@"152570318200694" andDelegate:self];
    
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if (![facebook isSessionValid]) {
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_education_history", 
                                @"email",
                                @"publish_stream",
                                nil];
        [facebook authorize:permissions];
    }
    [defaults setBool:YES forKey:@"UsedFBLogin"];
    [defaults synchronize];
}

-(void)fbDidNotLogin:(BOOL)cancelled{

}

@end
