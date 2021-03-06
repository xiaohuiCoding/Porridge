//
//  ThirdViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/6/17.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "ThirdViewController.h"
#import "XHNetwork.h"
#import "UIImage+GIF.h"

@interface ThirdViewController ()
{
    UIButton *btn;
    UILabel *downloadLabel;
    UILabel *progressLabel;
    NSTimer *timer;
    CGFloat progressNum;
    NSString *progressStr;
}
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"third";
    
    //原生UIImageView加载URL
    //    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 74, 300, 400)];
    //    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1399501/imperial_beer.jpg"]];
    //    UIImage *image = [UIImage imageWithData:imageData];
    //    imgView.image = image;
    //    [self.view addSubview:imgView];
    
    
    //1.网络请求接口数据并解析
    //    XHNetwork *network = [XHNetwork sharedInstance];
    //    NSDictionary *parametersDic = @{@"username":@"18239926527",@"userpwd":@"E10ADC3949BA59ABBE56E057F20F883E",@"clientmark":@"iphone"};
    //    [network postWithURLString:@"http://121.42.200.18:8080/shoptest/api/userLogin" parameters:parametersDic result:^(id obj, NSError *error) {
    //
    //        NSLog(@"接口返回的数据：%@",obj);
    //    }];
    
    
    //2.网络请求接口数据并下载至本地
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = [UIColor blueColor];
    btn.frame = CGRectMake(100, 114, 100, 30);
    [btn setTitle:@"下载" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(downloadPic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    downloadLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 160, 100, 30)];
    downloadLabel.backgroundColor = [UIColor lightGrayColor];
    downloadLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:downloadLabel];
    
    progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    progressLabel.backgroundColor = [UIColor greenColor];
    progressLabel.textAlignment = NSTextAlignmentCenter;
    [downloadLabel addSubview:progressLabel];
    
    //加载gif
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 100)];
    [self.view addSubview:imgView];
    
    //用这种加载后图不会动，只显示第一张子图
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"gif"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    UIImage *image = [UIImage imageWithData:data];
////    UIImage *image = [UIImage imageWithContentsOfFile:path];
//    imgView.image = image;
    
    //用SDWebImage中提供的分类方法加载即可（貌似某个旧版本才支持，最新的版本不支持了）
//    imgView.image = [UIImage sd_animatedGIFNamed:@"test"];
}

- (void)downloadPic
{
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.userInteractionEnabled = NO;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(passValue) userInfo:nil repeats:YES];
    
    XHNetwork *network = [XHNetwork sharedInstance];
    [network downloadFileWithURLString:@"https://raw.githubusercontent.com/wiki/xiaohuiCoding/blogImages/Demo/resource_20180611_6.png" result:^(NSString *filePath, float progressNumber, NSString *progressString, NSError *error) {
        progressNum = progressNumber;
        progressStr = progressString;
    }];
}

- (void)passValue
{
    NSLog(@"progressNum:%f",progressNum);
    NSLog(@"progressStr:%@",progressStr);
    
    downloadLabel.text = progressStr;
    progressLabel.frame = CGRectMake(0, 0, downloadLabel.bounds.size.width*progressNum, 30);
    
    if ([progressStr isEqualToString:@"100.00%"]) {
        
        downloadLabel.text = @"下载完毕";
        [timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
