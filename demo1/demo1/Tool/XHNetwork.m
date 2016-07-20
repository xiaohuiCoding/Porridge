//
//  XHNetwork.m
//  demo1
//
//  Created by 冯小辉 on 16/3/28.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "XHNetwork.h"
#import "AFNetworking.h"

@implementation XHNetwork

+ (XHNetwork *)sharedInstance
{
    static XHNetwork *netWork;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWork = [[XHNetwork alloc] init];
    });
    return netWork;
}

//GET请求
- (void)getWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters result:(XHNetworkBlock)result
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //manager.requestSerializer.timeoutInterval = 30;
    //NSURL *url = [NSURL URLWithString:[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
    
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"GET进度：%@",downloadProgress.localizedDescription);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"请求成功！");
        result(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败！");
        result(nil,error);
    }];
}

//POST请求
- (void)postWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters result:(XHNetworkBlock)result
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"POST进度：%@",uploadProgress.localizedDescription);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        result(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        result(nil,error);
    }];
}

//上传图片
- (void)postImageWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters imageData:(NSData *)imageData result:(XHNetworkBlock)result
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (imageData) {
            [formData appendPartWithFileData:imageData name:@"xxx" fileName:@"xxx.png" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"上传图片进度：%@",uploadProgress.localizedDescription);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        result(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        result(nil,error);
    }];
}

//上传视频
- (void)postMovieWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters movieData:(NSData *)movieData movieLogoImage:(UIImage *)movieLogoImage result:(XHNetworkBlock)result
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (movieData) {
            [formData appendPartWithFileData:movieData name:@"xxx" fileName:@"xxx" mimeType:@"video-sgi-movie"];
        }
        if (movieLogoImage) {
            NSData *imageData = UIImageJPEGRepresentation(movieLogoImage, 1.0);
            [formData appendPartWithFileData:imageData name:@"xxx" fileName:@"xxx.png" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"上传视频进度：%@",uploadProgress.localizedDescription);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        result(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        result(nil,error);
    }];
}

//下载文件
- (void)downloadFileWithURLString:(NSString *)URLString result:(XHDownloadBlock)result
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __block CGFloat proo;
    __block NSString *prooString;
    void (^progress)(NSProgress *) = ^(NSProgress *prog) {
        proo = (CGFloat)prog.completedUnitCount/prog.totalUnitCount;
        if (proo > 0) {
            prooString = [[NSString stringWithFormat:@"%.2f",proo*100] stringByAppendingString:@"%"];
            result(nil,proo,prooString,nil);
        }
    };
    
    NSProgress *p = nil;
    progress(p);
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        if ([filePath absoluteString].length > 7) {
//            NSString *string = [[filePath absoluteString] substringFromIndex:7];
//            result(string,prooString,error);
//        }
    }];
    
    //    NSProgress *p = nil;
    //    progress(p);
    
    [downloadTask resume];
}

//网络监听
- (void)networkReachability
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                NSLog(@"未知信号");
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"没有信号");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"手机信号");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"WiFi信号");
                break;
            }
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end
