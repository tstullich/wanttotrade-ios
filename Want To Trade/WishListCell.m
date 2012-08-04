//
//  WishListCell.m
//  Want To Trade
//
//  Created by Sam  on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WishListCell.h"

@implementation WishListCell

@synthesize bookTitleLabel = _bookTitleLabel;
@synthesize majorLabel = _majorLabel;
@synthesize priceLabel = _priceLabel;
@synthesize bookImage = _bookImage;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
