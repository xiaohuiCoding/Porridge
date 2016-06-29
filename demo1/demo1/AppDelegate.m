//
//  AppDelegate.m
//  demo1
//
//  Created by 冯小辉 on 16/3/21.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "AppDelegate.h"
#import "UserGuideViewController.h"
#import "AdvertiseView.h"
#import "TabBarController.h"
//#import "AFNetworkActivityIndicatorManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"沙盒路径：%@",NSHomeDirectory());
    
    //[NSThread sleepForTimeInterval:1.0];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    
//    //用户引导页（图片资源在本地）
    
//    BOOL isGuided = [[NSUserDefaults standardUserDefaults] boolForKey:User_Guided];
//    if (isGuided) {
//        [self showMainPage];
//    }
//    else {
//        [self showUserGuidePage];
//    }
    
    
    
    
    ////
    [self showMainPage];
    
    
    //广告图（图片资源通过URL加载）
    
    //1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [self getFilePathWithImageName:[kNSUserDefaults valueForKey:AdImageName]];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (isExist) {
        AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        advertiseView.adImageFilePath = filePath;
        [advertiseView showAdvertisePage];
    }
    //2.无论沙盒中是否存在广告图片，都需要调用接口，判断广告图片是否更新
    [self getAdvertiseImage];
    
    
                                        
    
//    //设置缓存
//    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
//    [NSURLCache setSharedURLCache:urlCache];
//    //添加活动指示器
//    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    return YES;
}

#pragma 用户引导页（图片资源在本地）

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

#pragma 广告图（图片资源通过URL加载）

//判断文件是否存在
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

//初始化广告
- (void)getAdvertiseImage
{
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg"];
    NSString *imageURL = imageArray[arc4random() % imageArray.count];
    //获取图片名：xxx.jpg
    NSArray *stringArray = [imageURL componentsSeparatedByString:@"/"];
    NSString *imageName = stringArray.lastObject;
    //拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    
    //如果不存在该图片，则删除旧图片，下载新图片
    if (!isExist) {
        [self downloadAdvertiseImageWithURL:imageURL imageName:imageName];
    }
}

//根据图片名拼接文件路径
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[pathArray objectAtIndex:0] stringByAppendingPathComponent:imageName];
        return filePath;
    }
    return nil;
}

//下载图片
- (void)downloadAdvertiseImageWithURL:(NSString *)imageURL imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^ {
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *filePath = [self getFilePathWithImageName:imageName];  //保存文件名
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {
            NSLog(@"save success!");
            [self deleteOldImage];
            [kNSUserDefaults setValue:imageName forKey:AdImageName];
            [kNSUserDefaults synchronize];
        }
        else {
            NSLog(@"save failure!");
        }
    });
}

//删除旧图片
- (void)deleteOldImage
{
    NSString *imageName = [kNSUserDefaults valueForKey:AdImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:filePath error:nil];
    }
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
