//
//  LWPrivacyUtils.m
//  Laiwang
//
//  Created by 胡 伟 on 13-9-24.
//  Copyright (c) 2013年 Alibaba(China)Technology Co.,Ltd. All rights reserved.
//

#import "LWPrivacyUtils.h"
#import "AVFoundation/AVFoundation.h"
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation LWPrivacyUtils


/* 获取录音权限 */
+ (void) requestMicrophonePermission:(void (^)(BOOL granted))block {
    //
    typeof (block) localBlock =  [block copy];
    // iOS7.0及以上
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)])
    {
        [[AVAudioSession sharedInstance] performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted)
        {
            dispatch_async(dispatch_get_main_queue(), ^ {
                localBlock(granted);
            });
        }];
    }
    else
    {
        localBlock(YES);
    }
#pragma clang diagnostic pop
}

/* 获取相机权限 */
+ (void) requestCameraPermission:(void (^)(BOOL granted))block {
    [self requestCameraPermission:block isShowAlertView:NO];
}

+ (void) requestCameraPermission:(void (^)(BOOL granted))block isShowAlertView:(BOOL) isShow
{
    typeof (block) localBlock =  [block copy];
    
   // 先判断是否有系统相机权限
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        localBlock(false);
        if (isShow) {
            [self showAlertView:@"相机"];
        }
        return;
    }
    // iOS7.0及以上
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        NSInteger authStatus = (int)[[AVCaptureDevice class] performSelector:@selector(authorizationStatusForMediaType:) withObject:AVMediaTypeVideo];
        if(authStatus == 3 /*AVAuthorizationStatusAuthorized*/)
        {
            localBlock(true);
        }
        else if (authStatus == 0/*AVAuthorizationStatusNotDetermined*/)
        {
            // Explicit user permission is required for media capture, but the user has not yet granted or denied such permission.
            if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType:completionHandler:)])
            {
                [[AVCaptureDevice class] performSelector:@selector(requestAccessForMediaType:completionHandler:)
                                              withObject:AVMediaTypeVideo
                                              withObject:^(BOOL granted)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         localBlock(granted);
                     });
                 }];
            }
        }
        else if (authStatus == 1 /*AVAuthorizationStatusRestricted*/)
        {
            // The client is not authorized to access the hardware for the media type. The user cannot change
            // the client's status, possibly due to active restrictions such as parental controls being in place.
            localBlock(false);
            if (isShow)
            {
                [self showAlertView:@"相机"];
            }
        }
        else if (authStatus == 2 /*AVAuthorizationStatusDenied*/)
        {
            localBlock(false);
            if (isShow)
            {
                [self showAlertView:@"相机"];
            }
        }
        else
        {
            localBlock(YES);
        }
    }
    else
    {
        localBlock(true);
    }
#pragma clang diagnostic pop
}

+ (void)showAlertView:(NSString *)serviceName
{
    NSURL *url = [NSURL URLWithString:@"app-settings:"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[[UIAlertView alloc] initWithTitle:@""
                                    message:[NSString stringWithFormat:@"请打开设置-隐私-%@\n允许“%@”访问%@",serviceName,[GlobalObject sharedInstance].appName, serviceName]
                           cancelButtonItem:[RIButtonItem itemWithLabel:NSLocalizedString(@"取消", @"取消")]
                           otherButtonItems:[RIButtonItem itemWithLabel:NSLocalizedString(@"去设置", @"去设置")
                                                                 action:^{
                                                                     [[UIApplication sharedApplication] openURL:url];
                                                                 }], nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle:@""
                                    message:[NSString stringWithFormat:@"请打开设置-隐私-%@\n允许“%@”访问%@",serviceName,[GlobalObject sharedInstance].appName, serviceName]
                           cancelButtonItem:nil
                           otherButtonItems:[RIButtonItem itemWithLabel:NSLocalizedString(@"确定", @"确定")], nil] show];
    }
    
}


/**
 *  获取照片权限
 *
 *  @param block
 *  @param isShow <#isShow description#>
 */
+ (void)requestPhotoPermission:(void (^)(BOOL isDetermined))block isShowAlertView:(BOOL) isShow
{
    typeof (block) localBlock =  [block copy];
    ALAuthorizationStatus authStatus = (int)[ALAssetsLibrary authorizationStatus];
    if(authStatus == ALAuthorizationStatusAuthorized)
    {
        localBlock(YES);
    } else if(authStatus == ALAuthorizationStatusNotDetermined) {
        localBlock(YES);
    } else if(authStatus == ALAuthorizationStatusRestricted) {
        localBlock(NO);
        if (isShow)
        {
            [self showAlertView:@"照片"];
        }
    } else if(authStatus == ALAuthorizationStatusDenied) {
        localBlock(NO);
        if (isShow) {
            [self showAlertView:@"照片"];
        }
    } else {
        localBlock(YES);
    }
    
}

+ (void)requestAddressBookPermission:(void (^)(BOOL isDetermined))block
{
    [self requestAddressBookPermission:block isShowAlertView:YES];
}

+ (void)requestAddressBookPermission:(void (^)(BOOL isDetermined))block isShowAlertView:(BOOL)isShow
{
    ABAuthorizationStatus abStatus = ABAddressBookGetAuthorizationStatus();
    __block BOOL accessGranted = NO;
    if (kABAuthorizationStatusNotDetermined == abStatus) {
        //用户还没决定，等待用户决定，线程才继续执行;
        ABAddressBookRef tempAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(tempAddressBook,
                                                 ^(bool granted, CFErrorRef error) {
                                                     accessGranted = granted;
                                                     dispatch_semaphore_signal(sema);
                                                 });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        if (tempAddressBook) {
            CFRelease(tempAddressBook);
            tempAddressBook = NULL;
        }
    } else if (kABAuthorizationStatusAuthorized == abStatus) {
        // 用户已经选择过授权了
        accessGranted = YES;
    } else {
        // 用户已经拒绝授权了
        accessGranted = NO;
    }
    block(accessGranted);
    if (!accessGranted) {
        if (isShow) {
            [self showAlertView:@"通讯录"];
        }
    }
}



@end
