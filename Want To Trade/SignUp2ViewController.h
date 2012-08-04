//
//  SignUp2ViewController.h
//  Want To Trade
//
//  Created by Sam  on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUp2ViewController : UIViewController<NSURLConnectionDataDelegate>

@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *pwField;
@property (nonatomic, retain) IBOutlet UIButton *allDoneButton;
@property (atomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSString *responseString;
@property (readwrite) BOOL done;
@property (nonatomic, retain) UIActivityIndicatorView *activity;

-(void)createSignUp:(NSString *)withEmail andPw:(NSString *)pw;
-(IBAction)buttonPressed:(id)sender;

@end
