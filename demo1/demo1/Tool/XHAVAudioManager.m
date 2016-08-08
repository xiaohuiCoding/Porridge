//
//  XHAVAudioManager.m
//  demo1
//
//  Created by 冯小辉 on 16/8/8.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "XHAVAudioManager.h"

@implementation XHAVAudioManager

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:item];
}

+ (XHAVAudioManager *)sharedManager
{
    static XHAVAudioManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XHAVAudioManager alloc] init];
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
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    //[self.player replaceCurrentItemWithPlayerItem:item];
    
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

@end
