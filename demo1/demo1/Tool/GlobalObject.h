//
//  GlobalObject.h
//  demo1
//
//  Created by xiaohui on 2017/6/16.
//  Copyright © 2017年 xinguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalObject : NSObject

+ (GlobalObject *)sharedInstance;

@property (nonatomic, copy) NSString *appName;

@end
