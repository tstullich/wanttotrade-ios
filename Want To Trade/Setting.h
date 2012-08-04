//
//  Setting.h
//  Want To Trade
//
//  Created by Sam  on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Setting : NSObject

@property (nonatomic, retain) NSString *theSetting;
@property (nonatomic, retain) NSString *theDetail;

-(id)initWithSetting:(NSString *)setting andDetail:(NSString *)detail;

@end
