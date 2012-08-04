//
//  SignUp2ViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignUp2ViewController.h"
#import "SignUpSuccessViewController.h"
#import "AppDelegate.h"

@interface SignUp2ViewController ()

@end

@implementation SignUp2ViewController

@synthesize emailField;
@synthesize pwField;
@synthesize allDoneButton;
@synthesize receivedData;
@synthesize responseString;
@synthesize done;
@synthesize activity;

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
    self.done = NO;
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activity.hidesWhenStopped = YES;
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
    if([[segue identifier] isEqualToString:@"SignUpSuccessSegue"]){
        NSLog(@"Dat Shit Cray\n");
        SignUpSuccessViewController *svc = [segue destinationViewController];
        svc.navigationItem.hidesBackButton = YES;
    }
}

-(void)createSignUp:(NSString *)withEmail andPw:(NSString *)pw{
    NSMutableString *theURL = [[NSMutableString alloc] initWithString:@"https://cloud.skypaz.com/soa/pipes/http?bsuser=wtt.com-skypaz-Signup&bspass=wtt2012"];
    [theURL appendFormat:@"&Email=%@&Password=%@", withEmail, pw];
    NSLog(@"%@\n", theURL);
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:theURL]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:10.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:@"Couldn't make a connection to the server. Please make sure your internet connection is on." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [activity stopAnimating];
        [alert show];
    }
    self.done = YES;
}

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
        [view resignFirstResponder];
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

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"Data is %@\n", responseString);
    
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    appDel.userEmail = emailField.text;
    appDel.userID = responseString; 
}

-(IBAction)buttonPressed:(id)sender{
    [activity startAnimating];
    while (!done) {
        [self createSignUp:emailField.text andPw:pwField.text];
    }
    
    [self performSegueWithIdentifier:@"SignUpSuccessSegue" sender:self];
}
@end
