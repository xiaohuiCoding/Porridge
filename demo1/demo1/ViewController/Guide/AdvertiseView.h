//
//  AdvertiseView.h
//  demo1
//
//  Created by 冯小辉 on 16/6/28.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertiseView : UIView
{
    UIImageView *advertiseImageView;
    UIButton *countBtn;
    NSTimer *countTimer;
    int count;
}

@property (nonatomic, copy) NSString *adImageFilePath;

- (void)showAdvertisePage;

@end
