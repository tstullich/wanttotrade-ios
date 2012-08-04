//
//  Book.m
//  Want To Trade
//
//  Created by Sam  on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Book.h"

@implementation Book

@synthesize bookTitle = _bookTitle;
@synthesize author = _author;
@synthesize major = _major;
@synthesize price = _price;
@synthesize offers = _offers;
@synthesize owner = _owner;
@synthesize condition = _condition;
@synthesize bookID = _bookID;
@synthesize edition = _edition;

-(id)initWithTitle:(NSString *)title andPrice:(NSString *)price andMajor:(NSString *)major{
    _bookTitle = title;
    _major = major;
    _price = price;
    
    return self;
}

-(id)initWithTitle:(NSString *)title andOffers:(NSString *)offers{
    _bookTitle = title;
    _offers = offers;
    
    return self;
}

-(id)initWithJson:(NSDictionary *)jsonOptions{
    if ([jsonOptions objectForKey:@"bookTitle"] != nil) {
     _bookTitle = [jsonOptions objectForKey:@"bookTitle"];   
    }
    if ([jsonOptions objectForKey:@"bookAuthor"] != nil){
        _author = [jsonOptions objectForKey:@"bookAuthor"];
    }
    if ([jsonOptions objectForKey:@"bookPrice"] != nil){
        _price = [jsonOptions objectForKey:@"bookPrice"];
    }
    if ([jsonOptions objectForKey:@"bookMajor"] != nil) {
        _major = [jsonOptions objectForKey:@"bookMajor"];
    }
    if ([jsonOptions objectForKey:@"bookCondition"] != nil){
        _condition = [jsonOptions objectForKey:@"bookCondition"];
    }
    if ([jsonOptions objectForKey:@"bookOwner"] != nil){
        _owner = [jsonOptions objectForKey:@"bookOwner"];
    }
    if ([jsonOptions objectForKey:@"bookID"] != nil){
        _bookID = [jsonOptions objectForKey:@"bookID"];
    }
    if ([jsonOptions objectForKey:@"bookEdition"] != nil) {
        _condition = [jsonOptions objectForKey:@"bookEdition"];
    }
    if([jsonOptions objectForKey:@"bookOffers"] != nil){
        _offers = [jsonOptions objectForKey:@"bookOffers"];
    }
    return self;
}

@end
