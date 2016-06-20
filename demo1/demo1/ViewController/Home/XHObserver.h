//
//  XHObserver.h
//  demo1
//
//  Created by 冯小辉 on 16/3/30.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHObserver : NSObject

//由于："- (void)setValue:(nullable id)value forKey:(NSString *)key"，所以，声明成数字型和字符型是有区别的，因为值参数必须是id类型，键参数必须是字符型。
@property(nonatomic,  copy) NSString *name;
@property(nonatomic,assign) CGFloat  score;

@end
