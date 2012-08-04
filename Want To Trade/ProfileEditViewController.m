//
//  ProfileEditViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileEditViewController.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "FileHandler.h"
#import "SettingsCell.h"
#import "Setting.h"
#import "EditDetailViewController.h"

@interface ProfileEditViewController ()

@end

@implementation ProfileEditViewController

@synthesize userPhoto = _userPhoto;
@synthesize delegate = _delegate;
@synthesize mainDelegate = _mainDelegate;
@synthesize settingsList = _settingsList;
@synthesize selectedIndex = _selectedIndex;


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
    
    _settingsList = [[NSMutableArray alloc] initWithCapacity:10];
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    
    if (appDel.userName != nil) {
        [_settingsList addObject:[[Setting alloc] initWithSetting:@"Name" andDetail:appDel.userName]];
    }
    else {
        [_settingsList addObject:[[Setting alloc] initWithSetting:@"Name" andDetail:@"Add A Name"]];
    }
    if (appDel.userEmail != nil){
        [_settingsList addObject:[[Setting alloc] initWithSetting:@"Email" andDetail:appDel.userEmail]];
    }
    else {
        [_settingsList addObject:[[Setting alloc] initWithSetting:@"Email" andDetail:@"Add An Email"]];
    }
    if (appDel.userSchool != nil){
        [_settingsList addObject:[[Setting alloc] initWithSetting:@"School" andDetail:appDel.userSchool]];
    }
    else {
        [_settingsList addObject:[[Setting alloc] initWithSetting:@"School" andDetail:@"Add A School"]];
    }
    if (appDel.userMajor != nil) {
        [_settingsList addObject:[[Setting alloc] initWithSetting:@"Major" andDetail:appDel.userMajor]];
    }
    else {
        [_settingsList addObject:[[Setting alloc] initWithSetting:@"Major" andDetail:@"Add A Major"]];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{   
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    appDel.userPhoto = _userPhoto.image;
    if ([[segue identifier] isEqualToString:@"ProfileEditSegue"]) {
        EditDetailViewController *evc = [segue destinationViewController];
        Setting *aSetting = [_settingsList objectAtIndex:_selectedIndex];
        evc.editItem.text = aSetting.theDetail;
        evc.navigationItem.title = aSetting.theSetting;
        
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *) theTextField{
    [theTextField resignFirstResponder];
    
    return YES;
}

-(IBAction)cancel:(id)sender{
    [self.delegate profileEditViewControllerDidSave:self];
}

-(IBAction)save:(id)sender{
    [self.delegate profileEditViewControllerDidCancel:self];
}

-(IBAction)getPhoto:(id)sender{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        [self presentModalViewController:picker animated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissModalViewControllerAnimated:YES];
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate]; 
    appDel.userPhoto = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    _userPhoto.image = appDel.userPhoto;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_settingsList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell"];
    NSLog(@"Found a Cell\n");
    
    if (cell == nil){
        cell = [[SettingsCell alloc] init];
    }
    Setting *newSetting = [_settingsList objectAtIndex:indexPath.row];
    cell.settingTextLabel.text = [newSetting theSetting];
    cell.thisDetailTextLabel.text = [newSetting theDetail];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndex = indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"ProfileEditSegue" sender:self];
}

@end
