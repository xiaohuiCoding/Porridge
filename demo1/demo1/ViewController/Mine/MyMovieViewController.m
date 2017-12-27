//
//  MyMovieViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/8/4.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "MyMovieViewController.h"
#import "XHAVVideoManager.h"
#import "DetailViewController.h"
#import "TXScrollLabelView.h"

@interface MyMovieViewController ()
{
    NSArray   *urlStringArray;
    NSInteger currentIndex;
}
@end

@implementation MyMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    urlStringArray = @[@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4",
                       @"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"];
    
    UIButton *btn1 = [GlobalObject newButton:CGRectMake(100, 100, 60, 40) title:@"第一部" titleColor:nil normalBkg:nil highlightedBkg:nil];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(playTheFirst:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [GlobalObject newButton:CGRectMake(200, 100, 60, 40) title:@"暂停" titleColor:nil normalBkg:nil highlightedBkg:nil];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(playPause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [GlobalObject newButton:CGRectMake(100, 200, 60, 40) title:@"上一部" titleColor:nil normalBkg:nil highlightedBkg:nil];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(playTheLast:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [GlobalObject newButton:CGRectMake(200, 200, 60, 40) title:@"下一部" titleColor:nil normalBkg:nil highlightedBkg:nil];
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(playTheNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    currentIndex = 0;
    
    //2.创建TXScrollLabelView
    TXScrollLabelView *scrollLabelView = [TXScrollLabelView scrollWithTitle:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈" type:0 velocity:0.5 options:UIViewAnimationOptionTransitionFlipFromTop];
    scrollLabelView.frame = CGRectMake(10, 300, 200, 30);
    //3.开始滚动
    [scrollLabelView beginScrolling];
    [self.view addSubview:scrollLabelView];
    
    UIButton *pushButton = [GlobalObject newButton:CGRectMake(200, 350, 60, 40) title:@"push" titleColor:nil normalBkg:nil highlightedBkg:nil];
    pushButton.backgroundColor = [UIColor redColor];
    [pushButton addTarget:self action:@selector(pushToDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

- (void)pushToDetail
{
    DetailViewController *vc = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)playTheFirst:(NSString *)url
{
    url = urlStringArray[0];
    [[XHAVVideoManager sharedManager] playWithURLString:url];
//    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:[XHAVAudioManager sharedManager].player];
//    self.playerLayer.frame = CGRectMake(0, 260, DSWidth, 200);
//    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
//    [self.view.layer addSublayer:self.playerLayer];

    
    currentIndex = 0;
    
    NSLog(@"currentIndex = %ld",currentIndex);
}

- (void)playPause
{
    [[XHAVVideoManager sharedManager] pause];
}

- (void)playTheLast:(NSString *)url
{
    if (currentIndex == 0) {
        currentIndex = urlStringArray.count;
    }
    
    currentIndex --;
    url = urlStringArray[currentIndex];
    [[XHAVVideoManager sharedManager] playWithURLString:url];
    
    NSLog(@"currentIndex = %ld", currentIndex);
}

- (void)playTheNext:(NSString *)url
{
    if (currentIndex == urlStringArray.count - 1) {
        currentIndex = -1;
    }
    
    currentIndex ++;
    url = urlStringArray[currentIndex];
    [[XHAVVideoManager sharedManager] playWithURLString:url];
    
    NSLog(@"currentIndex = %ld", currentIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
