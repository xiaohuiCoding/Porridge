//
//  TabBar.h
//  demo1
//
//  Created by 冯小辉 on 16/6/17.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabBarDelegate <NSObject>

- (void)tabBarDidSelectedRiseButton;

@end

@interface TabBar : UIView

@property (nonatomic, copy) NSArray *tabBarItems;
@property (nonatomic, weak) id <TabBarDelegate> delegate;

@end
