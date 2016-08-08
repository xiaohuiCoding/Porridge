//
//  XHAVVideoManager.m
//  demo1
//
//  Created by 冯小辉 on 16/8/8.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "XHAVVideoManager.h"

@implementation XHAVVideoManager

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:item];
}

+ (XHAVVideoManager *)sharedManager
{
    static XHAVVideoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XHAVVideoManager alloc] init];
    });
    return manager;
}

#pragma mark - lazy load

- (AVPlayer *)player
{
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}

- (void)playWithURLString:(NSString *)urlString
{
    if (item) {
        [item removeObserver:self forKeyPath:@"status"];
    }
    
    item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlString]];
    //self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    [self.player replaceCurrentItemWithPlayerItem:item];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = CGRectMake(0, 260, DSWidth, 200);
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    [[self getCurrentVC].view.layer addSublayer:self.playerLayer];

    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singleCycle) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
}

- (void)singleCycle
{
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self play];
    NSLog(@"single cycle ing!");
}

- (void)play
{
    if (!isReady) {
        return;
    }
    [self.player play];
    isPlaying = YES;
}

- (void)pause
{
    if (!isPlaying) {
        return;
    }
    [self.player pause];
    isPlaying = NO;
    NSLog(@"the song is paused!");
}

#pragma mark - observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"keyPath = %@, change = %@", keyPath, change);
    
    AVPlayerItemStatus status = [change[@"new"] integerValue];
    
    NSLog(@"current status = %ld",status);
    
    switch (status) {
            
        case AVPlayerItemStatusUnknown:
            NSLog(@"unknown status!");
            break;
            
        case AVPlayerItemStatusReadyToPlay:
            NSLog(@"ready to play!");
            isReady = YES;
            [self play];
            break;
            
        case AVPlayerItemStatusFailed:
            NSLog(@"play failed!");
            break;
            
        default:
            break;
    }
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *currentVC = [[UIApplication sharedApplication] keyWindow].rootViewController;
    while ([currentVC presentedViewController] != nil) {
        currentVC = [currentVC presentedViewController];
    }
    return currentVC;
}

@end
