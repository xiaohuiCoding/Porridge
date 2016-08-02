//
//  XHNetwork.h
//  demo1
//
//  Created by 冯小辉 on 16/3/28.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

typedef void (^XHNetworkBlock)(id obj,NSError *error);
typedef void (^XHDownloadBlock)(NSString *filePath, float progressNumber, NSString *progressString,NSError *error);

@interface XHNetwork : NSObject

@property(nonatomic,assign) CGFloat completedUnitCount;    //完成单位数

+ (XHNetwork *)sharedInstance;

//GET请求
- (void)getWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters result:(XHNetworkBlock)result;

//POST请求
- (void)postWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters result:(XHNetworkBlock)result;

//上传图片
- (void)postImageWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters imageData:(NSData *)imageData result:(XHNetworkBlock)result;

//上传视频
- (void)postMovieWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters movieData:(NSData *)movieData movieLogoImage:(UIImage *)movieLogoImage result:(XHNetworkBlock)result;

//下载文件
- (void)downloadFileWithURLString:(NSString *)URLString result:(XHDownloadBlock)result;

//网络监听
- (void)networkReachability;

@end
