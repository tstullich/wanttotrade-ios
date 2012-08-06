//
//  WishListSearchCell.h
//  Want To Trade
//
//  Created by Sam  on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListSearchCell : UITableViewCell{
    UIImageView *bookImage;
    UILabel *titleLabel;
    UILabel *majorLabel;
    UILabel *priceLabel;
}

@property (nonatomic, retain) IBOutlet UIImageView *bookImage;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *majorLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;

@end
