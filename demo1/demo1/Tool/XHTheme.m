//
//  XHTheme.m
//  demo1
//
//  Created by 冯小辉 on 16/7/19.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "XHTheme.h"

@implementation XHTheme

+ (XHTheme *)shareInstance
{
    static XHTheme *theme = nil;
    @synchronized (self) {
        if (theme == nil) {
            theme = [[XHTheme alloc] init];
        }
    }
    return theme;
}

@end
