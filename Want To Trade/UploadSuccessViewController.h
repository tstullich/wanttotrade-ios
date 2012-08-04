//
//  UploadSuccessViewController.h
//  Want To Trade
//
//  Created by Sam  on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface UploadSuccessViewController : UIViewController<FBDialogDelegate, FBSessionDelegate>{
    Facebook *facebook;
}

@property (nonatomic, retain) IBOutlet UIImageView *bookView;
@property (nonatomic, retain) Facebook *facebook;

@end
