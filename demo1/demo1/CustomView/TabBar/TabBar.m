//
//  TabBar.m
//  demo1
//
//  Created by 冯小辉 on 16/6/17.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "TabBar.h"
#import "TabBarItem.h"

@implementation TabBar

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self config];
    }
    
    return self;
}

#pragma mark - Private Method

- (void)config {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, DSWidth, 5)];
    topLine.image = [UIImage imageNamed:@"tapbar_top_line"];
    [self addSubview:topLine];
}

#pragma mark - Setter

- (void)setTabBarItems:(NSArray *)tabBarItems {
    
    _tabBarItems = tabBarItems;
    NSInteger itemTag = 0;
    
    for (id item in tabBarItems) {
        if ([item isKindOfClass:[TabBarItem class]]) {
            if (itemTag == 0) {
                ((TabBarItem *)item).selected = YES;
            }
            [((TabBarItem *)item) addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchDown];
            [self addSubview:item];
            if (((TabBarItem *)item).tabBarItemType != TabBarItemTypeRise) {
                ((TabBarItem *)item).tag = itemTag;
                itemTag++;
            }
        }
    }
}

//仅第三个item响应tabBarDidSelectedRiseButton方法
- (void)itemSelected:(TabBarItem *)sender {
    
    if (sender.tabBarItemType != TabBarItemTypeRise) {
        [self setSelectedIndex:sender.tag];
    } else {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(tabBarDidSelectedRiseButton)]) {
                [self.delegate tabBarDidSelectedRiseButton];
            }
        }
    }
}

- (void)setSelectedIndex:(NSInteger)index {
    
    for (TabBarItem *item in self.tabBarItems) {
        if (item.tag == index) {
            item.selected = YES;
        } else {
            item.selected = NO;
        }
    }
    
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    UITabBarController *tabBarController = (UITabBarController *)keyWindow.rootViewController;
    if (tabBarController) {
        tabBarController.selectedIndex = index;
    }
}

@end
