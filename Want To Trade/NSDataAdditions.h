//
//  NSDataAdditions.h
//  Want To Trade
//
//  Created by Sam  on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (NSDataAdditions)

+ (NSData *) base64DataFromString:(NSString *)string;

@end
