//
//  NSString.h
//  Want To Trade
//
//  Created by Sam  on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringAdditions)

+(NSString *) base64StringFromData:(NSData *)data length:(int)length;

@end
