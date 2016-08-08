//
//  XHTools.m
//  LRByInterface
//
//  Created by fengxiaohui on 15/8/13.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "XHTools.h"

@implementation XHTools

//获取appDelegate
+ (AppDelegate *)getApp
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return app;
}

//判断字符串不为空且不是空格
+ (BOOL)stringIsNotNullTrim:(NSString *)string
{
    NSString *str = [string  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (str == nil || str.length == 0 || [str isEqualToString:@""]) {
        return YES;
    }
    else {
        return NO;
    }
}

//判断手机号码有效
+ (BOOL)isValidMobilePhoneNumber:(NSString *)string
{
    //^1(3[0-9]|4[57]|5[012356789]|8[0-9]|7[0-7])\\d{8}$
    //手机号以13，14， 15，17，18开头，八个 \d 数字字符
    //NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[012356789]|8[0-9]|7[0-7])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:string];
}

+ (NSString *)md5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

//判断字符串为空
+ (BOOL)stringIsBlank:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//验证返回的字符串是否为空
+ (BOOL)stringReturnNull:(NSString *)string
{
    NSString *ss = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([ss isEqual: [NSNull null]] || ss == nil || [ss isEqualToString: @""] || [ss isEqualToString: @"<null>"]||ss.length == 0 )
    {
        return YES;
    }
    return NO;
}

//删除系统webView自带的黑色边框
+ (void)deleteWebViewBord:(UIWebView *)webView
{
    for(id subview in webView.subviews) {
        if ([[subview  class] isSubclassOfClass: [UIScrollView  class]]) {
            ((UIScrollView *)subview).bounces = NO;
        }
        webView.scrollView.bounces=NO;
    }
}

//动画
+ (void)cATransitionAnimation:(UIView *)toView typeIndex:(NSInteger)typeIndex subTypeIndex:(NSInteger)subTypeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation
{
    @try {
        CATransition *transtion = [CATransition animation];
        transtion.duration = duration;
        transtion.timingFunction = UIViewAnimationCurveEaseInOut;
        switch (typeIndex) {
            case 0:
                transtion.type = kCATransitionFade;
                break;
            case 1:
                transtion.type = kCATransitionPush;
                break;
            case 2:
                transtion.type = kCATransitionReveal;
                break;
            case 3:
                transtion.type = kCATransitionMoveIn;
                break;
            case 4:
                transtion.type = @"cube";
                break;
            case 5:
                transtion.type = @"suckEffect";
                break;
            case 6:
                transtion.type = @"oglFlip";
                break;
            case 7:
                transtion.type = @"rippleEffect";
                break;
            case 8:
                transtion.type = @"pageCurl";
                break;
            case 9:
                transtion.type = @"pageUnCurl";
                break;
            case 10:
                transtion.type = @"cameraIrisHollowOpen";
                break;
            case 11:
                transtion.type = @"cameraIrisHollowClose";
                break;
            default:
                transtion.type = kCATransitionFade;
                break;
        }
        switch (subTypeIndex) {
            case 0:
                transtion.subtype = kCATransitionFromLeft;
                break;
            case 1:
                transtion.subtype = kCATransitionFromRight;
                break;
            case 2:
                transtion.subtype = kCATransitionFromBottom;
                break;
            case 3:
                transtion.subtype = kCATransitionFromTop;
                break;
            default:
                transtion.subtype = kCATransitionFromLeft;
                break;
        }
        animation();
        if (toView.layer != nil && (id)toView.layer != [NSNull null])
        {
            [[toView layer] addAnimation:transtion forKey:@"animation"];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

//将数组转化为json
+ (NSString*)arrayToJson:(NSArray *)arr
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//字符串生成唯一哈希标识
+ (NSString*)haxi:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

//获取字符串的字节长度(注意编码格式，本例为NSUnicode。另外，还有NSUTF8格式。)
+ (int)convertToByte:(NSString*)str {
    
    int strlength = 0;
    char* p = (char*)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

@end
