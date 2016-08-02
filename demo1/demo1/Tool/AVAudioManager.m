//
//  AVAudioManager.m
//  demo1
//
//  Created by 冯小辉 on 16/8/2.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "AVAudioManager.h"

@implementation AVAudioManager

+ (AVAudioManager *)sharedManager
{
    static AVAudioManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AVAudioManager alloc] init];
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
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
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
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"keyPath = %@, change = %@", keyPath, change);
    
    AVPlayerItemStatus status = [change[@"new"] integerValue];
    
    switch (status) {
            
        case 0:
            NSLog(@"unknown resource!");
            break;
        
        case 1:
            isReady = YES;
            [self play];
            break;
            
        case 2:
            NSLog(@"play failed!");
            break;
            
        default:
            break;
    }
}

@end
