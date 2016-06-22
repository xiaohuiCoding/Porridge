//
//  ScanViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/5/19.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>

@property(nonatomic,strong)UIView                     *scanRectView;//扫描矩形视图

@property(nonatomic,strong)AVCaptureDevice            *device;//设备
@property(nonatomic,strong)AVCaptureDeviceInput       *input;//设备输入流
@property(nonatomic,strong)AVCaptureMetadataOutput    *output;//元数据输出流
@property(nonatomic,strong)AVCaptureSession           *session;//会话
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;//视频预览层

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"扫描二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize windowSize = [UIScreen mainScreen].bounds.size;
    
    CGSize scanSize = CGSizeMake(windowSize.width*3/4, windowSize.width*3/4);
    CGRect scanRect = CGRectMake((windowSize.width-scanSize.width)/2, (windowSize.height-scanSize.height)/2, scanSize.width, scanSize.height);
    
    scanRect = CGRectMake(scanRect.origin.y/windowSize.height, scanRect.origin.x/windowSize.width, scanRect.size.height/windowSize.height,scanRect.size.width/windowSize.width);
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:([UIScreen mainScreen].bounds.size.height<500)?AVCaptureSessionPreset640x480:AVCaptureSessionPresetHigh];
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    self.output.rectOfInterest = scanRect;
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    self.scanRectView = [[UIView alloc] init];
    self.scanRectView.frame = CGRectMake(0, 0, scanSize.width, scanSize.height);
    self.scanRectView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    [self.view addSubview:self.scanRectView];
    self.scanRectView.layer.borderColor = [UIColor redColor].CGColor;
    self.scanRectView.layer.borderWidth = 1;
    
    //开始捕获
    [self.session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count == 0) {
        return;
    }
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:metadataObject.stringValue delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.session startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
