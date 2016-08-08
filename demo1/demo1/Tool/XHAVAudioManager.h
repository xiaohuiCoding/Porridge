//
//  XHAVAudioManager.h
//  demo1
//
//  Created by 冯小辉 on 16/8/8.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>

@interface XHAVAudioManager : NSObject
{
    BOOL isReady;
    BOOL isPlaying;
    AVPlayerItem *item;
}

@property (nonatomic, strong) AVPlayer *player;

+ (XHAVAudioManager *)sharedManager;

- (AVPlayer *)player;

- (void)playWithURLString:(NSString *)urlString;

- (void)play;

- (void)pause;

@end
