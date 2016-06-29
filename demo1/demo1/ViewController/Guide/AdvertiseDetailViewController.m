//
//  AdvertiseDetailViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/6/28.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "AdvertiseDetailViewController.h"

@interface AdvertiseDetailViewController ()
{
    NSString *advertiseURL;
    UIWebView *webView;
}
@end

@implementation AdvertiseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"广告详情页";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header-arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backToHomePage)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.backgroundColor = [UIColor whiteColor];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com/"]]];
    [self.view addSubview:webView];
}

- (void)backToHomePage
{
    [self.navigationController popViewControllerAnimated:YES];
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
