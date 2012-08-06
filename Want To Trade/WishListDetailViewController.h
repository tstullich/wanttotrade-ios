//
//  WishListDetailViewController.h
//  Want To Trade
//
//  Created by Sam  on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListDetailViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIImageView *bookImage;
@property (nonatomic, retain) IBOutlet UILabel *bookTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *authorLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *ownerLabel;
@property (nonatomic, readwrite) NSInteger bookIndex;

@end
