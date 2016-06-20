//
//  TabBarItem.h
//  demo1
//
//  Created by 冯小辉 on 16/6/17.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TabBarItemType) {
    
    TabBarItemTypeNormal = 0,
    TabBarItemTypeRise,
};

@interface TabBarItem : UIButton

@property (nonatomic, assign) TabBarItemType tabBarItemType;

@end
