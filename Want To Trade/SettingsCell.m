//
//  SettingsCell.m
//  Want To Trade
//
//  Created by Sam  on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsCell.h"

@implementation SettingsCell

@synthesize settingTextLabel = _settingTextLabel;
@synthesize thisDetailTextLabel = _thisDetailTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
