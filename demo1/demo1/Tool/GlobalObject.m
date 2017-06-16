//
//  GlobalObject.m
//  demo1
//
//  Created by xiaohui on 2017/6/16.
//  Copyright © 2017年 xinguang. All rights reserved.
//

#import "GlobalObject.h"
#import <CommonCrypto/CommonDigest.h>

@implementation GlobalObject

- (NSString *)appName {
    
    if (!_appName) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:bundlePath];
        NSString *appName = [dict objectForKey:@"CFBundleName"];
        //        NSString *appName = [dict objectForKey:@"CFBundleDisplayName"];
        _appName = [NSString stringWithString:appName];
    }
    return _appName;
}

+ (GlobalObject *)sharedInstance {
    
    static GlobalObject *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalObject alloc] init];
    });
    return  instance;
}

+ (AppDelegate *)getAppDelegate {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate;
}

+ (UIWindow *)getWindow {
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return window;
}

+ (UIViewController *)getCurrentViewController {
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    }
    while (Rootvc!=nil);
    
    return currVC;
}

+ (UIViewController *)getCurrentVCCC {
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

- (UIViewController *)getCurrentVC {
    
    UIViewController *currentVC = [[UIApplication sharedApplication] keyWindow].rootViewController;
    while ([currentVC presentedViewController] != nil) {
        currentVC = [currentVC presentedViewController];
    }
    return currentVC;
}

+ (void)autoHideKeyboard:(UIView *)view {
    
    for (UIView *v in [view subviews]) {
        if ([v isKindOfClass:[UITextField class]] || [v isKindOfClass:[UITextView class]]) {
            [v resignFirstResponder];
        }
        if ([[v subviews] count] > 0) {
            [self autoHideKeyboard:v];
        }
    }
}

+ (UILabel *)newLabel:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font {
    
    UILabel *lb = [[UILabel alloc] initWithFrame:frame];
    lb.text = text;
    lb.textColor = textColor;
    lb.textAlignment = textAlignment;
    lb.font = font;
    return lb;
}

+ (UIButton *)newButton:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor normalBkg:(UIImage *)normalBkg highlightedBkg:(UIImage *)highlightedBkg {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:normalBkg forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightedBkg forState:UIControlStateHighlighted];
    return btn;
}

+ (UIImageView *)newImageView:(CGRect)frame image:(UIImage *)image {
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = image;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    return imgView;
}

+ (BOOL)verifyMobilePhoneNumber:(NSString *)numberString {
    
    //手机号以13，15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[012356789]|8[0-9]|7[0-7])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:numberString];
}

+ (BOOL)verifyIDCard:(NSString *)IDCard {
    
    NSString *IDCardRegex = @"^[1-9]\\d{5}(18|19|20){1}(\\d{2})(01|02|03|04|05|06|07|08|09|10|11|12)([1-2][0-9]|30|31|[0][1-9])(\\d{3})(\\d|[x,X]){1}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",IDCardRegex];
    return [pre evaluateWithObject:IDCard];
}

+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)verifyString:(NSString *)string {
    
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (str == nil || str.length == 0 || [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (BOOL)verifyStringOfReturn:(NSString *)string {
    
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (str == nil || str.length == 0 || [str isEqualToString:@""] || [str isEqual:[NSNull null]] || [str isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

+ (NSString *)filterSpecialString:(NSString *)string {
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@/：；（）¥「」＂、[]{}#%-*+=_\\|~<>$€^•'@#$%^&*()_+'\""];
    NSString *resultString = @"";
    for (int i = 0; i < string.length; i++) {
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [str rangeOfCharacterFromSet:set];
        if (range.location != NSNotFound) {
            str = @"";
        }
        resultString = [resultString stringByAppendingString:str];
    }
    return resultString;
}

+ (CGRect)getCGRectOfText:(NSString *)string withTextFont:(CGFloat)font {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGSize size = CGSizeMake(DSWidth, 0);
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect;
}

+ (NSString *)md5:(NSString *)string {
    
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

+ (NSString *)arrayToJSONString:(NSArray *)array {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

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

+ (NSMutableAttributedString *)converToDigitalString:(NSString *)ceshi Color:(UIColor *)red beginLocation:(NSInteger)begin {
    
    //扫描字符串中的数字
    NSScanner *scanner = [NSScanner scannerWithString:ceshi];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    NSString *numberStr = [NSString stringWithFormat:@"%d",number];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:ceshi];
    float legh = numberStr.length;
    [str addAttribute:NSForegroundColorAttributeName value:red range:NSMakeRange(begin, legh)];
    //Arial-BoldItalicMT 倾斜字体
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(begin, legh)];
    return str;
}

+ (NSMutableAttributedString *)ModifyTheColorForWord:(NSString *)ceshi Color:(UIColor *)color range:(NSRange)range {
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:ceshi];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    //Arial-BoldItalicMT 倾斜字体
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
    return str;
}

+ (NSString *)getDate:(NSString *)date {
    
    NSString *str=date;//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",detaildate);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (NSMutableArray *)arrayWithMemberIsOnly:(NSArray *)array {
    
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [array count]; i++)
    {
        @autoreleasepool
        {
            if ([categoryArray containsObject:[array objectAtIndex:i]] == NO)
            {
                [categoryArray addObject:[array objectAtIndex:i]];
            }
        }
    }
    return categoryArray;
}

+ (void)deleteBorderOfWebView:(UIWebView *)webView {
    
    for(id subview in webView.subviews) {
        if ([[subview  class] isSubclassOfClass: [UIScrollView  class]]) {
            ((UIScrollView *)subview).bounces = NO;
        }
        webView.scrollView.bounces=NO;
    }
}

+ (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (void)UIViewAnimationTransition:(UIView *)toView typeIndex:(NSInteger)typeIndex duration:(NSTimeInterval)duration animation:(void (^)(void))animation {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    
    switch (typeIndex) {
        case 0:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:toView cache:YES];
            break;
        case 1:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:toView cache:YES];
            break;
        case 2:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:toView cache:YES];
            break;
        case 3:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:toView cache:YES];
            break;
        default:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:toView cache:YES];
            break;
    }
    animation();
    [UIView commitAnimations];
}

+ (void)cATransitionAnimation:(UIView *)toView typeIndex:(NSInteger)typeIndex subTypeIndex:(NSInteger)subTypeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation {
    
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

@end
