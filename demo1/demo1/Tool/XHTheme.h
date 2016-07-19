//
//  XHTheme.h
//  demo1
//
//  Created by 冯小辉 on 16/7/19.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHTheme : NSObject

+ (XHTheme *)shareInstance;

@property (nonatomic, assign) BOOL isNightStyle;

@end
