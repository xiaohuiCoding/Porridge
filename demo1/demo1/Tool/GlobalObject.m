//
//  GlobalObject.m
//  demo1
//
//  Created by xiaohui on 2017/6/16.
//  Copyright © 2017年 xinguang. All rights reserved.
//

#import "GlobalObject.h"

@implementation GlobalObject

+ (GlobalObject *)sharedInstance {
    
    static GlobalObject *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalObject alloc] init];
    });
    return  instance;
}

- (NSString *)appName {
    
    if (!_appName) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:bundlePath];
        NSString *appName = [dict objectForKey:@"CFBundleDisplayName"];
        _appName = [NSString stringWithString:appName];
    }
    return _appName;
}

@end
