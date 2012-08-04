//
//  UploadBookViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UploadBookViewController.h"
#import "UploadSuccessViewController.h"
#import "Book.h"
#import "HomeViewController.h"
#import "MyBooksViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface UploadBookViewController ()

@end

@implementation UploadBookViewController

@synthesize uploadedImage;
@synthesize cameraButton;
@synthesize galleryButton;
@synthesize titleField;
@synthesize authorField;
@synthesize priceField;
@synthesize conditionField;
@synthesize editionField;
@synthesize scrollView;
@synthesize receivedData;
@synthesize responseString;
@synthesize options = _options;
@synthesize activeField;
@synthesize yPositionStore = _yPositionStore;
@synthesize appDel = _appDel;
@synthesize titleLabel;
@synthesize authorLabel;
@synthesize allFieldsFilled = _allFieldsFilled;
@synthesize priceLabel;
@synthesize editionLabel;
@synthesize conditionLabel;

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
    titleField.returnKeyType = UIReturnKeyDone;
    authorField.returnKeyType = UIReturnKeyDone;
    priceField.returnKeyType = UIReturnKeyDone;
    priceField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    editionField.returnKeyType = UIReturnKeyDone;
    editionField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    conditionField.returnKeyType = UIReturnKeyDone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    //Will need to look into this further
    //[scrollView setContentSize:CGSizeMake(320, 500)];
    
    UIButton *someButton = [[UIButton alloc] init];
    [someButton addTarget:self action:@selector(submitData)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(submitData:)];
    self.navigationItem.rightBarButtonItem=mailbutton;
    
    _allFieldsFilled = NO;
    
    _appDel = [[UIApplication sharedApplication] delegate];
}

//If an account hasn't been created, a small error message will pop up
//and take you back to the Home View
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)getPhoto:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if((UIButton *) sender == galleryButton){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    else {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentModalViewController:picker animated:YES];
}

//Assigns the picked image to the empty photo view
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissModalViewControllerAnimated:YES];
    uploadedImage.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

//Adds the uploaded image to the next view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"UploadSuccessSegue"]) {
         _appDel.uploadedImage = self.uploadedImage.image;
    }
    else if ([[segue identifier] isEqualToString:@"UploadCancelSegue"]) {
        HomeViewController *hvc = [segue destinationViewController];
        hvc.navigationItem.hidesBackButton = YES;
    }
}

//Returns a Mutable Dictionary containing all of the user input.
//Need to implement a check for an empty field.
-(NSMutableDictionary *)getFields{
    NSMutableDictionary *fieldCollection = [[NSMutableDictionary alloc] init];
    if ([self.titleField.text isEqualToString:@""]) {
        [fieldCollection setValue:@"N/A" forKey:@"bookTitle"];
    }
    else {
        [fieldCollection setValue:self.titleField.text forKey:@"bookTitle"];
    }
    if ([self.authorField.text isEqualToString:@""]) {
        [fieldCollection setValue:@"N/A" forKey:@"bookAuthor"];
    }
    else {
        [fieldCollection setValue:self.authorField.text forKey:@"bookAuthor"];
    }
    if ([self.priceField.text isEqualToString:@""]) {
        [fieldCollection setValue:@"0" forKey:@"bookPrice"];
    }
    else {
        [fieldCollection setValue:self.priceField.text forKey:@"bookPrice"];
    }
    if ([self.editionField.text isEqualToString:@""]) {
        [fieldCollection setValue:@"N/A" forKey:@"bookEdition"];
    }
    else {
        [fieldCollection setValue:self.editionField.text forKey:@"bookEdition"];
    }
    if ([self.conditionField.text isEqualToString:@""]) {
        [fieldCollection setValue:@"N/A" forKey:@"bookCondition"];
    }
    else {
        [fieldCollection setValue:self.conditionField.text forKey:@"bookCondition"];
    }
        [fieldCollection setValue:_appDel.userID forKey:@"bookOwner"];
        [fieldCollection setValue:@"0" forKey:@"bookOffers"];
    return fieldCollection;
}

-(void)submitData:(id)sender{
    if ([self.titleField.text isEqualToString:@""]) {
        [self.titleLabel setTextColor:[UIColor redColor]];
    }
    if ([self.authorField.text isEqualToString:@""]) {
        [self.authorLabel setTextColor:[UIColor redColor]];
    }
    if ([self.priceField.text isEqualToString:@""]) {
        [self.priceLabel setTextColor:[UIColor redColor]];
    }
    if ([self.conditionField.text isEqualToString:@""]) {
        [self.conditionLabel setTextColor:[UIColor redColor]];
    }
    else {
        _allFieldsFilled = YES;
    }
        if (_allFieldsFilled == NO) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Careful!" message:@"Not all fields were filled. Please make sure you do." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else {
            _options = [self getFields];
            
            //Add the Book Here
            
            
            [self performSelectorInBackground:@selector(upLoadBook:) withObject:_options];
        }
}

-(void)upLoadBook:(NSMutableDictionary *)theOptions{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Uploading...";
    
    NSMutableString *theURL = [[NSMutableString alloc] initWithString:@"https://cloud.skypaz.com/soa/pipes/http?bsuser=wtt.com-skypaz-UploadBook&bspass=wtt2012"];
    
    [theURL appendFormat:@"&Title=%@&Author=%@&Price=%@",  [theOptions objectForKey:@"bookTitle"], 
                                                           [theOptions objectForKey:@"bookAuthor"], 
                                                           [theOptions objectForKey:@"bookPrice"]];
    [theURL appendFormat:@"&Edition=%@&Condition=%@&Owner=%@", [theOptions objectForKey:@"bookEdition"],
                                                            [theOptions objectForKey:@"bookCondition"],
                                                            _appDel.userID];
    
    NSLog(@"%@\n", theURL);
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:theURL]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:10.0];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
        [connection start];
    });
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data];
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
    
    //Receives a response after book has been uploaded (Preferably a Book ID...)
    responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response String: %@", responseString);
    [_options setValue:responseString forKey:@"bookID"];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self performSegueWithIdentifier:@"UploadSuccessSegue" sender:self];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops." message:@" No internet connection.\n Please make sure you have a connection to the internet." 
                                                   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [alert show];
}

- (IBAction)dismissKeyboard:(id)sender{
    
    [activeField resignFirstResponder];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y - (keyboardSize.height-50));
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activeField = textField; 
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.activeField = nil;
}

@end