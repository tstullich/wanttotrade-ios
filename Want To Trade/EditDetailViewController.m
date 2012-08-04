//
//  EditDetailViewController.m
//  Want To Trade
//
//  Created by Sam  on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditDetailViewController.h"
#import "AppDelegate.h"

@interface EditDetailViewController ()

@end

@implementation EditDetailViewController

@synthesize editField = _editField;
@synthesize editItem = _editItem;
@synthesize appDel = _appDel;

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
    _editField.returnKeyType = UIReturnKeyDone;
    _appDel = [[UIApplication sharedApplication] delegate];
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Loading screen background.png"]];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
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
    if([[segue identifier] isEqualToString:@"ProfileEditSubmitSegue"]){
        if([self.navigationItem.title isEqualToString:@"Name"] && ![self.editField.text isEqualToString:@""]){
            [_appDel setUserName:_editField.text];
        }
        else if ([self.navigationItem.title isEqualToString:@"Email"] && ![self.editField.text isEqualToString:@""]) {
            [_appDel setUserEmail:_editField.text];
        }
        else if ([self.navigationItem.title isEqualToString:@"Major"] && ![self.editField.text isEqualToString:@""]) {
            [_appDel setUserMajor:_editField.text];
        }
        else if ([self.navigationItem.title isEqualToString:@"School"] && ![self.editField.text isEqualToString:@""]) {
            [_appDel setUserSchool:_editField.text];
        }
    }
}

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}

@end
