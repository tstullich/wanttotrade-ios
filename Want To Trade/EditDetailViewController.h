//
//  EditDetailViewController.h
//  Want To Trade
//
//  Created by Sam  on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface EditDetailViewController : UIViewController{
    UITextField *editField;
    UILabel *editItem;
    AppDelegate *appDel;
}

@property (nonatomic, retain) IBOutlet UITextField *editField;
@property (nonatomic, retain) IBOutlet UILabel *editItem;
@property (nonatomic, retain) AppDelegate *appDel;

@end
