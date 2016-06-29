//
//  AdvertiseView.m
//  demo1
//
//  Created by 冯小辉 on 16/6/28.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "AdvertiseView.h"

//广告展示的时间
static int const advertiseDuration = 3;

@implementation AdvertiseView

//重写set方法，并给广告视图赋值
- (void)setAdImageFilePath:(NSString *)adImageFilePath
{
    _adImageFilePath = adImageFilePath;
    advertiseImageView.image = [UIImage imageWithContentsOfFile:adImageFilePath];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    //1.广告图
    advertiseImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    advertiseImageView.contentMode = UIViewContentModeScaleAspectFill;
    advertiseImageView.clipsToBounds = YES;
    advertiseImageView.userInteractionEnabled = YES;
    [self addSubview:advertiseImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAdvertiseDetailPage)];
    [advertiseImageView addGestureRecognizer:tap];

    //2.跳过按钮
    countBtn = [[UIButton alloc] initWithFrame:CGRectMake(DSWidth - 80, 30, 60, 30)];
    countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
    [countBtn setTitle:[NSString stringWithFormat:@"跳过%d",advertiseDuration] forState:UIControlStateNormal];
    [countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    countBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    countBtn.layer.cornerRadius = 4;
    [self addSubview:countBtn];
}

- (void)showAdvertisePage
{
    //倒计时：定时器实现
    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    
//    //倒计时：GCD实现
//    [self startCountDownWithGCD];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window addSubview:self];
}

- (void)startCountDownWithGCD
{
    __block int timeout = advertiseDuration + 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            timeout --;
        }
    });
    dispatch_resume(timer);
}

- (void)startTimer
{
    count = advertiseDuration;
    countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:countTimer forMode:NSRunLoopCommonModes];
}

- (void)countDown
{
    count--;
    [countBtn setTitle:[NSString stringWithFormat:@"跳过%d",count] forState:UIControlStateNormal];
    if (count == 0) {
        [countTimer invalidate];
        countTimer = nil;
        [self dismiss];
    }
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//点击广告图片，从首页push至广告详情页
- (void)pushToAdvertiseDetailPage
{
    [self dismiss];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToAdvertiseDetail" object:nil];
}

@end
