//
//  UserGuideViewController.h
//  demo1
//
//  Created by 冯小辉 on 16/4/6.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "BaseViewController.h"

@interface UserGuideViewController : BaseViewController<UIScrollViewDelegate>
{
    NSArray       *imageArray;
    UIScrollView  *userGuideScrollView;
    UIPageControl *pgControl;
}

@end
