//
//  ServerRequest.m
//  Want To Trade
//
//  Created by Sam  on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 Class that calls to the server, requests JSON data for a given
 page and then returns it as a parsed NSDictionary object.
 */
#import "ServerRequest.h"
#import "SBJson.h"

@implementation ServerRequest

@synthesize responseData;
@synthesize responseString;

-(id)initWithPage:(NSString *) page{
    url = [[NSString alloc] initWithFormat:@"http:/wtt.skypaz.com/?v=%@", page];
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"Connection established\n");
    responseData = [NSMutableData alloc];
    responseString = [NSString alloc];
    return self;
}

-(void)connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response{
    [responseData setLength:0];
    NSLog(@"Response Received\n");
}

-(void)connection:(NSURLConnection *) connection didReceiveData:(NSData *)data{
    [responseData appendData:data];
    NSLog(@"Received Data\n");
}

-(void)connection:(NSURLConnection *) connection didFailWithError:(NSError *)error{
    responseString = [NSString stringWithFormat:@"Connection Failed: %@", [error description]];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Finished Loading. Found response string. %@", responseString);
    if ([responseString isEqualToString:@"\"Unable to find specified resource.\""]){
        self.responseString = [NSString stringWithFormat:@"Couldn't find resource"];
    }
    else {
        NSArray *items = [responseString JSONValue];
        for (NSString *value in items) {
            NSLog(@"Value is %@\n", value);
        }
        NSLog(@"Success\n");
    }
}

@end
