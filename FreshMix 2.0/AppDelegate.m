//
//  AppDelegate.m
//  FreshMix 2.0
//
//  Created by Robert Crosby on 8/30/14.
//  Copyright (c) 2014 8-Bit Pyramid. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"current"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"refresh"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isplaying"];
    NSInteger runs = [[NSUserDefaults standardUserDefaults] integerForKey:@"opened"];
    if (runs < 2) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showads"];
    }
    runs++;
    [[NSUserDefaults standardUserDefaults] setInteger:runs forKey:@"opened"];
    NSLog(@"%ld",(long)runs);
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"done"];
    [Parse setApplicationId:@"bMIME7j5W2U1J27ZrJWlaOFojjRgvskDmgsAaxk1"
                  clientKey:@"qQ6xrL9yeeaNv6v44Hdv12DSPa2IjdO94weAHEyH"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"doneloadingnum"];
    [[NSUserDefaults standardUserDefaults] setObject:@"No Current Track" forKey:@"nowplaying-song"];
    [[NSUserDefaults standardUserDefaults] setObject:@"Play a track" forKey:@"nowplaying-artist"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"justloaded"];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGFloat screenHeight = screenRect.size.height;
    
    if (screenHeight > 480) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"is3.5"];
        
        
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"is3.5"];
                
        
        
    }

    //[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"current"];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isplaying"];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"elapsed"];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
