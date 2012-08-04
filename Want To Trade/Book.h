//
//  Book.h
//  Want To Trade
//
//  Created by Sam  on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, retain) NSString *bookTitle;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *major;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *offers;
@property (nonatomic, retain) NSString *owner;
@property (nonatomic, retain) NSString *condition;
@property (nonatomic, retain) NSString *bookID;
@property (nonatomic, retain) NSString *edition;

-(id)initWithTitle:(NSString *)title andPrice:(NSString *)price 
            andMajor:(NSString *)major;

-(id)initWithTitle:(NSString *)title andOffers:(NSString *)offers;

-(id)initWithJson:(NSDictionary *)jsonOptions;

@end
