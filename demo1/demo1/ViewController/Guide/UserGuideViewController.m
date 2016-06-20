//
//  UserGuideViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/4/6.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "UserGuideViewController.h"
#import "AppDelegate.h"

@interface UserGuideViewController ()

@end

@implementation UserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageArray = [NSArray arrayWithObjects:@"h1.jpg", @"h2.jpg", @"h3.jpg",nil];
    
    [self addViews];
}

- (void)addViews
{
    userGuideScrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    userGuideScrollView.delegate = self;
    userGuideScrollView.contentSize = CGSizeMake(DSWidth*imageArray.count, DSHeight);
    userGuideScrollView.contentOffset = CGPointMake(0, 0);
    userGuideScrollView.pagingEnabled = YES;
    userGuideScrollView.bounces = NO;
    userGuideScrollView.showsHorizontalScrollIndicator = NO;
    userGuideScrollView.showsVerticalScrollIndicator = NO;
    userGuideScrollView.userInteractionEnabled = YES;
    [self.view addSubview:userGuideScrollView];
    
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(DSWidth*i, 0, DSWidth, DSHeight)];
        imgView.image = [UIImage imageNamed:imageArray[i]];
        imgView.userInteractionEnabled = YES;
        [userGuideScrollView addSubview:imgView];
        
        if (i == imageArray.count - 1) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame =CGRectMake((DSWidth - 150)/2, DSHeight - 100, 150, 40);
            [button setBackgroundImage:[UIImage imageNamed:@"立即体验"] forState:UIControlStateNormal];
            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(enterMainPage) forControlEvents:UIControlEventTouchUpInside];
            [imgView addSubview:button];
        }
    }
    
    pgControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 57/2,self.view.frame.size.height-50, 57, 15)];
    pgControl.numberOfPages = imageArray.count;
    pgControl.currentPage = 0;
    [self.view addSubview:pgControl];
}

- (void)enterMainPage
{
    [self.view removeFromSuperview];
    self.view = nil;
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app showMainPage];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:User_Guided];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
    
        if (pgControl.currentPage + 1 == pgControl.numberOfPages) {
            [self enterMainPage];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pgControl.currentPage=userGuideScrollView.contentOffset.x/DSWidth;
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
