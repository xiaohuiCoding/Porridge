//
//  SecondViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/6/17.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"second";
    
    //1.使用Core Animation
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 74, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 124)];//起始的中心点坐标
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 124)];//结束的中心点坐标
    animation.duration = 1.5;
    [view.layer addAnimation:animation forKey:nil];
    view.frame = CGRectOffset(view.frame, 100, 0);//动画结束后修改frame
    
    
    //2.隐式动画
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.frame = CGRectMake(0, 180, 100, 100);
    [self.view.layer addSublayer:layer];
    layer.frame = CGRectOffset(layer.frame, 100, 0);
    
    
    //3.使用View
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 100, 100)];
    view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view2];
    [UIView animateWithDuration:1.5 animations:^{
        view2.frame = CGRectMake(50, 300, 100, 100);
    } completion:^(BOOL finished) {
        view2.frame = CGRectMake(100, 300, 100, 100);
    }];
    
    
    //4.使用View的begin／commit模式
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 450, 100, 100)];
    view3.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view3];
    [UIView beginAnimations:@"xxx" context:nil];
    [UIView setAnimationDuration:1.5];
    view3.frame = CGRectMake(100, 450, 100, 100);
    [UIView commitAnimations];
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
