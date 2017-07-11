//
//  GlobalObject.h
//  demo1
//
//  Created by xiaohui on 2017/6/16.
//  Copyright © 2017年 xinguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface GlobalObject : NSObject

@property (nonatomic, copy) NSString *appName;

+ (GlobalObject *)sharedInstance;

#pragma mark - 获取AppDelegate对象

+ (AppDelegate *)getAppDelegate;

#pragma mark - 获取UIWindow对象

+ (UIWindow *)getWindow;

#pragma mark - 获取当前屏幕显示的UIViewController对象

+ (UIViewController *)getCurrentViewController;

#pragma mark - 键盘事件

// 自动隐藏
+ (void)autoHideKeyboard:(UIView *)view;

#pragma mark - 初始化UI控件

+ (UILabel *)newLabel:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font;

+ (UIButton *)newButton:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor normalBkg:(UIImage *)normalBkg highlightedBkg:(UIImage *)highlightedBkg;

+ (UIImageView *)newImageView:(CGRect)frame image:(UIImage *)image;

#pragma mark - 正则表达式的应用

// 验证手机号
+ (BOOL)verifyMobilePhoneNumber:(NSString *)phoneNumber;

// 验证身份证号
+ (BOOL)verifyIDCard:(NSString *)IDCard;

#pragma mark - 字符串判别

// 判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;

+ (BOOL)verifyString:(NSString *)string;

+ (BOOL)verifyStringOfReturn:(NSString *)string;

#pragma mark - 字符串处理

//过滤字符串中的特殊字符
+ (NSString *)filterSpecialString:(NSString *)string;

//获取文本的CGRect
+ (CGRect)getCGRectOfText:(NSString *)string withTextFont:(CGFloat)font;

//md5加密
+ (NSString *)md5:(NSString *)string;

//将数组转化为JSON字符串
+ (NSString *)arrayToJSONString:(NSArray *)array;

//字符串生成唯一哈希标识
+ (NSString*)haxi:(NSString*)input;

//获取字符串的字节长度(注意编码格式，本例为NSUnicode。另外，还有NSUTF8格式。)
+ (int)convertToByte:(NSString*)str;

//定义字符串中数字的颜色
+ (NSMutableAttributedString *)converToDigitalString:(NSString *)ceshi Color:(UIColor *)red beginLocation:(NSInteger)begin;

//修改整段字中部分字体颜色
+ (NSMutableAttributedString *)ModifyTheColorForWord:(NSString *)ceshi Color:(UIColor *)color range:(NSRange)range;

#pragma mark - 时间

//时间戳转换
+ (NSString *)getDate:(NSString *)date;

#pragma mark - 数组

//数组中元素去重
+ (NSMutableArray *)arrayWithMemberIsOnly:(NSArray *)array;

#pragma mark - webView

//删除webView的黑色边框
+ (void)deleteBorderOfWebView:(UIWebView *)webView;

#pragma mark - 图片处理

//压缩图片
+ (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize;

#pragma mark - 动画

+ (void)UIViewAnimationTransition:(UIView *)toView typeIndex:(NSInteger)typeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation;

+ (void)cATransitionAnimation:(UIView *)toView typeIndex:(NSInteger)typeIndex subTypeIndex:(NSInteger)subTypeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation;

@end
