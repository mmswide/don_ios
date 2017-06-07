//
//  AppDelegate.m
//  TestProject
//
//  Created by Fantastic on 26/08/16.
//  Copyright © 2016 Fantastic. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "PinCodeViewController.h"
#import <UIKit+AFNetworking.h>
#import "LoginViewController.h"
#import "LPNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // create an instance of the view controller you want to be displayed first
    MainViewController *mainVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:mainVC];
    
    // set it as the root view controller of the application's window
    [self.window setRootViewController:navigation];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    [self presentPinCodeLockIfNeeded];
    
//    [self showLoginView];
    
    return YES;
}

#pragma mark -
#pragma mark pin code lock

- (void) presentPinCodeLockIfNeeded
{
    if ([PinCodeViewController applicationIsLocked])
    {
        PinCodeViewController *controller = [PinCodeViewController new];
        [self.window.rootViewController presentViewController:controller animated:NO completion:nil];
    }
}

#pragma mark -
#pragma mark - Show Login View Controller
- (void) showLoginView {
    if ([LoginViewController applicationIsLocked])
    {
        LoginViewController *controller = [LoginViewController new];
        LPNavigationController *navController = [[LPNavigationController alloc]initWithRootViewController:controller];
        [self.window.rootViewController presentViewController:navController animated:NO completion:nil];
    }
}
- (void)logoutAuth {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool: NO forKey: @"Application Unlocked"];
    [userDefaults synchronize];
    LoginViewController *controller = [LoginViewController new];
    LPNavigationController *navController = [[LPNavigationController alloc]initWithRootViewController:controller];
    [self.window.rootViewController presentViewController:navController animated:NO completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
