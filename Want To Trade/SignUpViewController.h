//
//  SignUpViewController.h
//  Want To Trade
//
//  Created by Sam  on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface SignUpViewController : UIViewController<FBSessionDelegate, FBLoginDialogDelegate>{
    IBOutlet UIButton *fbLoginButton;
    Facebook *facebook;
    
}

@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *pwField;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) UIButton *fbLoginButton;

@end
