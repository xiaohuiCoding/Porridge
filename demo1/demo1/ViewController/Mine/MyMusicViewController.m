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
    NSInteger currentIndex;
    NSArray   *urlStringArray;
}
@end

@implementation MyMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentIndex = 0;
    
    urlStringArray = @[@"http://m1.music.126.net/gpi8Adr_-pfCuP7ZXk_F2w==/2926899953898363.mp3",
                       @"http://data.5sing.kgimg.com/G061/M0A/03/13/HZQEAFb493iAOeg5AHMiAfzZU0E739.mp3",
                       @"http://m1.music.126.net/gpi8Adr_-pfCuP7ZXk_F2w==/2926899953898363.mp3",
                       @"http://data.5sing.kgimg.com/G061/M0A/03/13/HZQEAFb493iAOeg5AHMiAfzZU0E739.mp3"];
    
    UIButton *btn1 = [XHObject newButton:CGRectMake(100, 100, 60, 40) title:@"开始" titleColor:nil normalBkg:nil highlightedBkg:nil];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(startPlaySong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [XHObject newButton:CGRectMake(100, 200, 60, 40) title:@"切歌" titleColor:nil normalBkg:nil highlightedBkg:nil];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(playNextSong:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)startPlaySong
{
    AVAudioManager *manager = [AVAudioManager sharedManager];
    [manager playWithURLString:urlStringArray[currentIndex]];
    [manager play];
    NSLog(@"currentIndex = %ld", currentIndex);
}

- (void)playNextSong:(NSString *)url
{
    currentIndex ++;
    
    url = urlStringArray[currentIndex];
    [[AVAudioManager sharedManager] playWithURLString:url];
    [[AVAudioManager sharedManager] play];
    
    NSLog(@"currentIndex = %ld", currentIndex);
    
    if (currentIndex == urlStringArray.count - 1) {
        currentIndex = -1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
