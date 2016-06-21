//
//  XHObserver.m
//  demo1
//
//  Created by 冯小辉 on 16/3/30.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "XHObserver.h"

@implementation XHObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"temperature"]) {
        
        NSLog(@"old value is %.1f,new value is %.1f",[change[@"old"] floatValue],[change[@"new"] floatValue]);
    }
}

@end
