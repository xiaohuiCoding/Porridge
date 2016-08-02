//
//  TabBarController.m
//  demo1
//
//  Created by 冯小辉 on 16/6/17.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
//#import "MineViewController.h"
//#import "MyViewController.h"
#import "MyMusicViewController.h"
#import "TabBar.h"
#import "TabBarItem.h"

@interface TabBarController ()<TabBarDelegate, UIActionSheetDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:homeVC];
    nav1.navigationBar.barTintColor = [UIColor purpleColor];
    [nav1.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:secondVC];
    nav2.navigationBar.barTintColor = [UIColor purpleColor];
    [nav2.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:thirdVC];
    nav3.navigationBar.barTintColor = [UIColor purpleColor];
    [nav3.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    
    FourthViewController *fourthVC = [[FourthViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:fourthVC];
    nav4.navigationBar.barTintColor = [UIColor purpleColor];
    [nav4.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    
//    MineViewController *mineVC = [[MineViewController alloc] init];
//    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:mineVC];
//    nav5.navigationBar.barTintColor = [UIColor purpleColor];
//    [nav5.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];

    
//    MyViewController *myVC = [[MyViewController alloc] init];
//    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:myVC];
//    nav5.navigationBar.barTintColor = [UIColor purpleColor];
//    [nav5.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    
    
    MyMusicViewController *myMusicVC = [[MyMusicViewController alloc] init];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:myMusicVC];
    nav5.navigationBar.barTintColor = [UIColor purpleColor];
    [nav5.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    
    
    self.viewControllers = @[nav1, nav2, nav3, nav4, nav5];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    TabBar *tabBar = [[TabBar alloc] initWithFrame:self.tabBar.bounds];
    
    CGFloat normalButtonWidth = (DSWidth * 3 / 4) / 4;
    CGFloat tabBarHeight = CGRectGetHeight(tabBar.frame);
    CGFloat publishItemWidth = (DSWidth / 4);
    
    TabBarItem *homeItem = [self tabBarItemWithFrame:CGRectMake(0, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"首页"
                                       normalImageName:@"home_normal.png"
                                     selectedImageName:@"home_highlight.png" tabBarItemType:TabBarItemTypeNormal];
    
    TabBarItem *sameCityItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth, 0, normalButtonWidth, tabBarHeight)
                                                     title:@"second"
                                           normalImageName:@"mycity_normal.png"
                                         selectedImageName:@"mycity_highlight.png" tabBarItemType:TabBarItemTypeNormal];
    
//    TabBarItem *publishItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2, 0, publishItemWidth, tabBarHeight)
//                                                    title:@"发布"
//                                          normalImageName:@"post_normal.png"
//                                        selectedImageName:@"post_normal.png" tabBarItemType:TabBarItemTypeRise];
    
    TabBarItem *publishItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2, 0, publishItemWidth, tabBarHeight)
                                                  title:@"third"
                                        normalImageName:@"post_normal.png"
                                      selectedImageName:@"post_normal.png" tabBarItemType:TabBarItemTypeNormal];
    
    TabBarItem *messageItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                    title:@"fourth"
                                          normalImageName:@"message_normal.png"
                                        selectedImageName:@"message_highlight.png" tabBarItemType:TabBarItemTypeNormal];
    TabBarItem *mineItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 3 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"我"
                                       normalImageName:@"account_normal.png"
                                     selectedImageName:@"account_highlight.png" tabBarItemType:TabBarItemTypeNormal];
    
    tabBar.tabBarItems = @[homeItem, sameCityItem, publishItem, messageItem, mineItem];
    tabBar.delegate = self;
    
    [self.tabBar addSubview:tabBar];  
}

- (TabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(TabBarItemType)tabBarItemType
{
    TabBarItem *item = [[TabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:8];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setImage:selectedImage forState:UIControlStateHighlighted];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateSelected];
    item.tabBarItemType = tabBarItemType;
    
    return item;
}

#pragma mark - LLTabBarDelegate

- (void)tabBarDidSelectedRiseButton
{
//    UIViewController *viewController = self.selectedViewController;
//    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
//                                                             delegate:self
//                                                    cancelButtonTitle:@"取消"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:@"拍照", @"从相册选取", nil];
//    [actionSheet showInView:viewController.view];
}

#pragma mark - UIActionSheetDelegate

//- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    //NSLog(@"buttonIndex = %ld", buttonIndex);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
