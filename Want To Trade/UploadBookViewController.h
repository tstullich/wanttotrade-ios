//
//  UploadBookViewController.h
//  Want To Trade
//
//  Created by Tim  on 7/13/12.
//  Copyright (c) 2012 Want To Trade, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UploadBookViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, 
                                                        UIScrollViewDelegate, NSURLConnectionDelegate, 
                                                        NSURLConnectionDataDelegate>{
    UIButton *galleryButton;
    UIButton *cameraButton;
    UIImageView *uploadedImage;
    UITextField *titleField, *authorField, *priceField, *conditionField;
    UITextField *editionField;
    UIScrollView *scrollView;
    UILabel *titleLabel, *authorLabel, *priceLabel, *editionLabel, *conditionLabel;
    NSMutableData *receivedData;
    NSString *responseString, *encodedImg;
    NSMutableDictionary *options;
    CGFloat yPositionStore;
    AppDelegate *appDel;
    BOOL allFieldsFilled;
}

@property (nonatomic, retain) IBOutlet UIButton *galleryButton;
@property (nonatomic, retain) IBOutlet UIButton *cameraButton;
@property (nonatomic, retain) IBOutlet UIImageView *uploadedImage;
@property (nonatomic, retain) IBOutlet UITextField *titleField;
@property (nonatomic, retain) IBOutlet UITextField *authorField;
@property (nonatomic, retain) IBOutlet UITextField *priceField;
@property (nonatomic, retain) IBOutlet UITextField *conditionField;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *editionField;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *authorLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *editionLabel;
@property (nonatomic, retain) IBOutlet UILabel *conditionLabel;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSString *responseString;
@property (nonatomic, retain) NSMutableDictionary *options;
@property (nonatomic, assign) UITextField *activeField;
@property (readwrite) CGFloat yPositionStore;
@property (nonatomic, retain) AppDelegate *appDel;
@property (assign) BOOL allFieldsFilled;
@property (nonatomic, retain) NSString *encodedImg;

-(IBAction)getPhoto:(id)sender;
-(IBAction)dismissKeyboard:(id)sender;
-(IBAction)submitData:(id)sender;

@end
