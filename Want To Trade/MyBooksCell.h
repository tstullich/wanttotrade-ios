//
//  MyBooksCell.h
//  Want To Trade
//
//  Created by Sam  on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBooksCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *bookImage;
@property (nonatomic, retain) IBOutlet UILabel *bookTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *offersLabel;

@end
