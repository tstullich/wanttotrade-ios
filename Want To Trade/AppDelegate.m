//
//  AppDelegate.m
//  Want To Trade
//
//  Created by Sam  on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadViewController.h"
#import "SignUpViewController.h"
#import "Book.h"
#import "SBJSON.h"
#import "FBConnect.h"

@implementation AppDelegate{
    NSMutableArray *items;
    
}


@synthesize window = _window;
@synthesize userName = _userName;
@synthesize recentAddsList = _recentAddsList;
@synthesize userEmail = _userEmail;
@synthesize userMajor = _userMajor;
@synthesize userPw = _userPw;
@synthesize userSchool = _userSchool;
@synthesize userID = _userID;
@synthesize wishList = _wishList;
@synthesize userPhoto = _userPhoto;
@synthesize uploadedImage = _uploadedImage;
@synthesize myBooksList = _myBooksList;
@synthesize completedTradesList = _completedTradesList;
@synthesize pendingTradesList = _pendingTradesList;
@synthesize facebook;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //[self performSelector:@selector(loadView) withObject:nil afterDelay:2.0];
    
    _wishList = [[NSMutableArray alloc] initWithCapacity:100];
    _recentAddsList = [[NSMutableArray alloc] initWithCapacity:100];
    _myBooksList = [[NSMutableArray alloc] initWithCapacity:100];
    NSLog(@"Lists Were Initialized. Maybe");
    
    UIImage *NavigationPortraitBackground = [[UIImage imageNamed:@"Blank Banner.png"]
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [[UINavigationBar appearance] setBackgroundImage:NavigationPortraitBackground
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Noteworthy-Bold" size:18], UITextAttributeFont,
      nil]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults boolForKey:@"firstTime"]){
        NSLog(@"Second Time Around\n");
        _userName = [defaults stringForKey:@"userName"];
        _userID = [defaults stringForKey:@"userID"];
        _userEmail = [defaults stringForKey:@"userEmail"];
        _userPhoto = [defaults objectForKey:@"userPhoto"];
        _userSchool = [defaults stringForKey:@"userSchool"];
        _userMajor = [defaults stringForKey:@"userMajor"];
        NSMutableArray *aList = [defaults objectForKey:@"userBooks"];
        for (Book *aBook in aList) {
            NSLog(@"%@", [aBook bookTitle]);
            [_myBooksList addObject:aBook];
        }
        
    }
    
    NSLog(@"Bundle ID: %@", [[NSBundle mainBundle] bundleIdentifier]);
    
    [defaults setBool:YES forKey:@"UsedFBLogin"];
    [defaults synchronize];
        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"The App went into the background. Updating Values...\n");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:NO forKey:@"firstTime"];
    [defaults setValue:self.userName forKey:@"userName"];
    [defaults setValue:self.userID forKey:@"userID"];
    [defaults setValue:self.userPhoto forKey:@"userPhoto"];
    [defaults setValue:self.userEmail forKey:@"userEmail"];
    [defaults setValue:self.userSchool forKey:@"userSchool"];
    [defaults setValue:self.userMajor forKey:@"userMajor"];
    [defaults setValue:self.myBooksList forKey:@"userBooks"];
    
    [defaults synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(NSString *)getListDirectory{
    NSArray *manyPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     return [manyPaths objectAtIndex:0];
}


@end
