//
//  ViewControllerDetail.m
//  demo1
//
//  Created by 冯小辉 on 16/3/29.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "ViewControllerDetail.h"
#import "ViewControllerDetailNext.h"

@interface ViewControllerDetail ()

@end

@implementation ViewControllerDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(returnBack)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"push" style:UIBarButtonItemStylePlain target:self action:@selector(toNextPage)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)returnBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)toNextPage
{
    ViewControllerDetailNext *detailNext = [[ViewControllerDetailNext alloc] init];
    detailNext.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailNext animated:YES];
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
