//
//  GenerateViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/5/19.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "GenerateViewController.h"

@interface GenerateViewController ()

@property(nonatomic,strong)UITextField *tfCodeTextField;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation GenerateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"生成二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.tfCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 94, DSWidth-80, 40)];
    self.tfCodeTextField.borderStyle = UITextBorderStyleLine;
    
//    self.tfCodeTextField.text = @"http://weixin.qq.com/r/bvjl0ADEL11QrUSz9618";
    
//    self.tfCodeTextField.text = @"https://u.wechat.com/EKdiIivxrJ5yTQQXbOgUv_A";
//    self.tfCodeTextField.text = @"https://u.wechat.com/EDzHdvFfnITqhooXAGWLt_k";
    
    self.tfCodeTextField.text = @"https://qr.alipay.com/12012264ffzak1rmj9f4wa5";

    self.tfCodeTextField.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:self.tfCodeTextField];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(DSWidth-60, 94, 50, 40)];
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"生成" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 150, 240, 240)];
    [self.view addSubview:self.imageView];
}

- (void)btnClicked
{
    NSString *text = self.tfCodeTextField.text;
    NSData *stringData = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    UIColor *onColor = [UIColor blackColor];
    UIColor *offColor = [UIColor whiteColor];
    
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    
    //绘制
    CGSize size = CGSizeMake(300, 300);
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    self.imageView.image = codeImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
