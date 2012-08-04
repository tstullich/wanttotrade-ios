//
//  ProfileEditViewController.h
//  Want To Trade
//
//  Created by Sam  on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProfileEditViewController;

@protocol ProfileEditViewControllerDelegate <NSObject>
-(void)profileEditViewControllerDidCancel:
(ProfileEditViewController *)controller;
-(void)profileEditViewControllerDidSave:
(ProfileEditViewController *)controller;

@end

@interface ProfileEditViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>{
}

@property (nonatomic, retain) IBOutlet UIImageView *userPhoto;
@property (atomic, retain) NSMutableArray *settingsList;
@property (nonatomic, readwrite) NSUInteger selectedIndex;
@property (retain) id mainDelegate;
@property (nonatomic, weak) id <ProfileEditViewControllerDelegate> delegate;

-(IBAction)cancel:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)getPhoto:(id)sender;

@end
