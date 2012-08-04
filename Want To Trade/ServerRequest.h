//
//  ServerRequest.h
//  Want To Trade
//
//  Created by Sam  on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServerRequest : NSObject{
    NSString *url, *responseString;
    NSURLRequest *request;
    NSMutableData *responseData;
}
-(id)initWithPage:(NSString *) page;

@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSString *responseString;
@end
