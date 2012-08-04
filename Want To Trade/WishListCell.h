//
//  WishListCell.h
//  Want To Trade
//
//  Created by Sam  on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *bookTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *majorLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UIImageView *bookImage;

@end
