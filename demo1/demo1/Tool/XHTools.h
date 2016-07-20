//
//  XHTools.h
//  LRByInterface
//
//  Created by fengxiaohui on 15/8/13.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>

@interface XHTools : NSObject

+ (AppDelegate *)getApp;

//判断字符串不为空且不是空格
+ (BOOL)stringIsNotNullTrim:(NSString *)string;

//判断手机号码有效
+ (BOOL)isValidMobilePhoneNumber:(NSString *)string;

//MD5加密
+ (NSString *)md5:(NSString *)string;

//判断字符串为空
+ (BOOL)stringIsBlank:(NSString *)string;

//验证返回的字符串是否为空
+ (BOOL)stringReturnNull:(NSString *)string;

//删除系统webView自带的黑色边框
+ (void)deleteWebViewBord:(UIWebView *)webView;

//动画
+ (void)cATransitionAnimation:(UIView *)toView typeIndex:(NSInteger)typeIndex subTypeIndex:(NSInteger)subTypeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation;

//将数组转化为json
+ (NSString*)arrayToJson:(NSArray *)arr;

//字符串生成唯一哈希标识
+ (NSString*)haxi:(NSString*)input;

//获取字符串的字节长度(注意编码格式，本例为NSUnicode。另外，还有NSUTF8格式。)
+ (int)convertToByte:(NSString*)str;


//    //利用JSONKit将容器数据类型的数据转化为JSON
//    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionary];
//    NSMutableDictionary *alert = [NSMutableDictionary dictionary];
//    NSMutableDictionary *aps = [NSMutableDictionary dictionary];
//    [alert setObject:@"a msg come!" forKey:@"body"];
//    [aps setObject:alert forKey:@"alert"];
//    [aps setObject:@"3" forKey:@"bage" ];
//    [aps setObject:@"def.mp3" forKey:@"sound"];
//    [jsonDic setObject:aps forKey:@"aps"];
//    NSString *strJson = [jsonDic JSONString];
//    NSLog(@"%@",strJson);

@end
