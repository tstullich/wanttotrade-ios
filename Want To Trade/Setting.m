//
//  Setting.m
//  Want To Trade
//
//  Created by Sam  on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Setting.h"

@implementation Setting

@synthesize theSetting = _theSetting;
@synthesize theDetail = _theDetail;

-(id)initWithSetting:(NSString *)setting andDetail:(NSString *)detail{
    _theSetting = setting;
    _theDetail = detail;
    
    return self;
}

@end
