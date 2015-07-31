//
//  SGKAppDelegate.m
//  DemoStruts
//
//  Created by 丁治文 on 14/12/31.
//  Copyright (c) 2014年 SumRise. All rights reserved.
//

#import "SGKAppDelegate.h"
#import "SGKMainTableViewController.h"
#import "SGKNotificaitonModel.h"
#import "SGKJump.h"

@implementation SGKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setWindowLevel:UIWindowLevelStatusBar];
    
    SGKMainTableViewController * mainTVC = [[SGKMainTableViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:mainTVC];
    [self.window setRootViewController:nav];
    
    UILocalNotification * noti = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (noti) {
        NSDictionary * userInfo = noti.userInfo;
        SGKNotificaitonModel * notiModel = [[SGKNotificaitonModel alloc] init];
        [notiModel setValuesForKeysWithDictionary:userInfo];
        [SGKJump jumpToAppWithNotification:notiModel from:nav pushType:kPushTypeNav];
    }
    
    [self.window makeKeyAndVisible];
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if (_userInfo) {
        SGKNotificaitonModel * notiModel = [[SGKNotificaitonModel alloc] init];
        [notiModel setValuesForKeysWithDictionary:_userInfo];
        [SGKJump jumpToAppWithNotification:notiModel from:self.window.rootViewController pushType:kPushTypeNav];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"recive" message:[NSString stringWithFormat:@"%@", userInfo] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
//}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    _userInfo = notification.userInfo;
    
    if (_userInfo) {
        SGKNotificaitonModel * notiModel = [[SGKNotificaitonModel alloc] init];
        [notiModel setValuesForKeysWithDictionary:_userInfo];
        if (![SGKJump isCurrentAearWithNotification:notiModel from:self.window.rootViewController pushType:kPushTypeNav]) {
            [SGKJump jumpToAppWithNotification:notiModel from:self.window.rootViewController pushType:kPushTypeNav];
        }
    }
}

@end
