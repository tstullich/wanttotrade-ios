//
//  FileHandler.m
//  Want To Trade
//
//  Created by Sam  on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FileHandler.h"


@implementation FileHandler

@synthesize items;

-(void)writeToFile:(NSString *)theFileName withInput:(NSString *)input{
    
    NSArray *manyPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *theDirectory = [manyPaths objectAtIndex:0];
    NSString *path = [theDirectory stringByAppendingPathComponent:theFileName];
    [input writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"File Writing may have been successful\n");
}

-(NSMutableDictionary *)readFromFile:(NSString *)theFileName {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:theFileName ofType:@"txt"];
    NSString *theData = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (theData){
        dict = [theData JSONValue];
    }
    NSLog(@"Book Title %@\n", [dict objectForKey:@"bookTitle"]);
    return dict;
}

@end
