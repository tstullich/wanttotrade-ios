//
//  ProfileViewController.h
//  Want To Trade
//
//  Created by Sam  on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UIScrollViewDelegate>{
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *emailLabel;
@property (nonatomic, retain) IBOutlet UILabel *schooLabel;
@property (nonatomic,retain) IBOutlet UILabel *majorLabel;
@property (nonatomic, strong) IBOutlet UIImageView *profilePhoto;

@end
