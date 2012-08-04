//
//  MyBooksViewController.h
//  Want To Trade
//
//  Created by Sam  on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MyBooksViewController : UITableViewController<NSURLConnectionDelegate>{
    NSInteger selectedIndex;
    AppDelegate *appDel;
    NSMutableData *receivedData;
    NSMutableArray *books;

}

@property (readwrite) NSInteger selectedIndex;
@property (nonatomic, retain) AppDelegate *appDel;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSString *responseString;
@property (atomic, retain) NSMutableArray *books;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
