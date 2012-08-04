//
//  FileHandler.h
//  Want To Trade
//
//  Created by Sam  on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@interface FileHandler : NSObject{
    NSString *fileName, *documentsDirectory, *appFile, *inputString;
    NSArray *paths;
    NSDictionary *items;
}

@property (nonatomic, retain) NSDictionary *items;

-(void)writeToFile: (NSString *)fileName withInput:(NSString *) input;

-(NSMutableDictionary *)readFromFile: (NSString *) fileName;

@end
