//
//  AppDelegate.m
//  demo1
//
//  Created by 冯小辉 on 16/3/21.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "AppDelegate.h"
#import "UserGuideViewController.h"
//#import "XHTabBarController.h"
#import "TabBarController.h"
//#import "AFNetworkActivityIndicatorManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"沙盒路径%@",NSHomeDirectory());
    
    [NSThread sleepForTimeInterval:1.0];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    BOOL isGuided = [[NSUserDefaults standardUserDefaults] boolForKey:User_Guided];
    if (isGuided) {
        [self showMainPage];
    }
    else {
        [self showUserGuidePage];
    }
    
    
//    //设置缓存
//    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
//    [NSURLCache setSharedURLCache:urlCache];
//    
//    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    return YES;
}

- (void)showUserGuidePage
{
    UserGuideViewController *userGuideVC = [[UserGuideViewController alloc] init];
    self.window.rootViewController = userGuideVC;
    [self.window makeKeyAndVisible];
}

- (void)showMainPage
{
    TabBarController *xhTabBarC = [[TabBarController alloc] init];
    self.window.rootViewController = xhTabBarC;
    [self.window makeKeyAndVisible];
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
