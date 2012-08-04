//
//  AppDelegate.h
//  Want To Trade
//
//  Created by Sam  on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
}
@property (strong, nonatomic) UIWindow *window;
@property (copy, readwrite) NSString *userName;
@property (copy, readwrite) NSString *userEmail;
@property (copy, readwrite) NSString *userPw;
@property (copy, readwrite) NSString *userSchool;
@property (copy, readwrite) NSString *userMajor;
@property (nonatomic, retain) UIImage *userPhoto;
@property (nonatomic, retain) NSString *userID;
@property (retain, atomic) NSMutableArray *wishList;
@property (retain, atomic) NSMutableArray *recentAddsList;
@property (retain, atomic) NSMutableArray *myBooksList;
@property (retain, atomic) NSMutableArray *completedTradesList;
@property (retain, atomic) NSMutableArray *pendingTradesList;
@property (nonatomic, retain) UIImage *uploadedImage;
@property (nonatomic, retain) Facebook *facebook;


@end
