//
//  RecentAddsViewController.h
//  Want To Trade
//
//  Created by Sam  on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentAddsViewController : UITableViewController<NSURLConnectionDelegate>{
    NSMutableArray *searchList;
    NSMutableData *receivedData;
    NSString *responseString;
    NSInteger *selectedIndex;
}

@property (atomic, retain) NSMutableArray *searchList;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSString *responseString;
@property (readwrite) NSInteger *selectedIndex;

@end
