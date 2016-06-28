//
//  XHObject.h
//  demo1
//
//  Created by 冯小辉 on 16/6/24.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface XHObject : NSObject

#pragma 获取系统对象

+ (AppDelegate *)getApp;

+ (UIWindow *)getWindow;

#pragma 键盘事件

//自动隐藏键盘
+ (void)autoHideKeyboard:(UIView *)view;

#pragma 新建UI控件

+ (UILabel *)newLabel:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font;

+ (UIButton *)newButton:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor normalBkg:(UIImage *)normalBkg highlightedBkg:(UIImage *)highlightedBkg;

+ (UIImageView *)newImageView:(CGRect)frame image:(UIImage *)image;

#pragma 正则表达式的应用及字符串处理

//验证手机号
+ (BOOL)verifyPhoneNumber:(NSString *)phoneNumber;

//验证身份证号
+ (BOOL)verifyIDCard:(NSString *)IDCard;

//验证空字符串
+ (BOOL)isBlankString:(NSString *)string;

//验证字符串
+ (BOOL)verifyString:(NSString *)string;

//验证字符串
+ (BOOL)verifyStringOfReturn:(NSString *)string;

//过滤字符串中的特殊字符
+ (NSString *)filterSpecialString:(NSString *)string;

//获取文本的CGRect
+ (CGRect)getCGRectOfText:(NSString *)string withTextFont:(CGFloat)font;

//md5加密
+ (NSString *)md5:(NSString *)string;

//将数组转化为JSON字符串
+ (NSString *)arrayToJSONString:(NSArray *)array;

//定义字符串中数字的颜色
+ (NSMutableAttributedString *)converToDigitalString:(NSString *)ceshi Color:(UIColor *)red beginLocation:(NSInteger)begin;

//修改整段字中部分字体颜色
+ (NSMutableAttributedString *)ModifyTheColorForWord:(NSString *)ceshi Color:(UIColor *)color range:(NSRange)range;

//时间戳转换
+ (NSString *)getDate:(NSString *)date;

//数组中元素去重
+ (NSMutableArray *)arrayWithMemberIsOnly:(NSArray *)array;

#pragma webView相关

//删除webView的黑色边框
+ (void)deleteBorderOfWebView:(UIWebView *)webView;

#pragma 图片处理

//压缩图片
+ (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize;

#pragma 动画

+ (void)UIViewAnimationTransition:(UIView *)toView typeIndex:(NSInteger)typeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation;








@end
