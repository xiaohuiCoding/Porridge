//
//  LWPrivacyUtils.h
//  Laiwang
//
//  Created by 胡 伟 on 13-9-24.
//  Copyright (c) 2013年 Alibaba(China)Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
/* 隐私Utils类， */
@interface LWPrivacyUtils : NSObject

/**
 * 获取麦克权权限
 * @block 返回是否有这个权限
 */
+ (void)requestMicrophonePermission:(void (^)(BOOL granted))block;

/**
 *  获取相机权限
 *
 *  @param block 返回是否有这个权限
 */
+ (void)requestCameraPermission:(void (^)(BOOL granted))block;

/**
 *  获取相机权限
 *
 *  @param block  返回是否有这个权限
 *  @param isShow 无权限的时候弹出alertView
 */
+ (void)requestCameraPermission:(void (^)(BOOL granted))block isShowAlertView:(BOOL)isShow;


/**
 *  获取照片权限
 *
 *  @param block  返回是否是第一次用，是否弹出过授权界面
 *  @param isShow 无权限的时候弹出alertView
 */
+ (void)requestPhotoPermission:(void (^)(BOOL isDetermined))block isShowAlertView:(BOOL)isShow;

/**
 *  获取通讯录权限
 *
 *  @param block <#block description#>
 */
+ (void)requestAddressBookPermission:(void (^)(BOOL isDetermined))block;

+ (void)requestAddressBookPermission:(void (^)(BOOL isDetermined))block isShowAlertView:(BOOL)isShow;


+ (void)showAlertView:(NSString *)serviceName;

@end
