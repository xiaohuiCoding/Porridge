//
//  MyMusicViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/8/2.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "MyMusicViewController.h"

#import "AVAudioManager.h"

@interface MyMusicViewController ()
{
    NSArray   *urlStringArray;
    NSInteger currentIndex;
}
@end

@implementation MyMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    urlStringArray = @[@"http://m1.music.126.net/gpi8Adr_-pfCuP7ZXk_F2w==/2926899953898363.mp3",
                       @"http://data.5sing.kgimg.com/G061/M0A/03/13/HZQEAFb493iAOeg5AHMiAfzZU0E739.mp3",
                       @"http://m1.music.126.net/gpi8Adr_-pfCuP7ZXk_F2w==/2926899953898363.mp3",
                       @"http://data.5sing.kgimg.com/G061/M0A/03/13/HZQEAFb493iAOeg5AHMiAfzZU0E739.mp3"];
    
    UIButton *btn1 = [XHObject newButton:CGRectMake(100, 100, 60, 40) title:@"第一首" titleColor:nil normalBkg:nil highlightedBkg:nil];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(playTheFirst) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [XHObject newButton:CGRectMake(200, 100, 60, 40) title:@"暂停" titleColor:nil normalBkg:nil highlightedBkg:nil];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(playPause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

    UIButton *btn3 = [XHObject newButton:CGRectMake(100, 200, 60, 40) title:@"上一首" titleColor:nil normalBkg:nil highlightedBkg:nil];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(playTheLast:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [XHObject newButton:CGRectMake(200, 200, 60, 40) title:@"下一首" titleColor:nil normalBkg:nil highlightedBkg:nil];
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(playTheNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    currentIndex = 0;
}

- (void)playTheFirst
{
    AVAudioManager *manager = [AVAudioManager sharedManager];
    [manager playWithURLString:urlStringArray[0]];
    NSLog(@"currentIndex = %ld", currentIndex);
}

- (void)playPause
{
    AVAudioManager *manager = [AVAudioManager sharedManager];
    [manager pause];
}

- (void)playTheLast:(NSString *)url
{
    if (currentIndex == 0) {
        currentIndex = urlStringArray.count;
    }
    
    currentIndex --;
    url = urlStringArray[currentIndex];
    [[AVAudioManager sharedManager] playWithURLString:url];
    NSLog(@"currentIndex = %ld", currentIndex);
}

- (void)playTheNext:(NSString *)url
{
    if (currentIndex == urlStringArray.count - 1) {
        currentIndex = -1;
    }
    
    currentIndex ++;
    url = urlStringArray[currentIndex];
    [[AVAudioManager sharedManager] playWithURLString:url];
    
    NSLog(@"currentIndex = %ld", currentIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
