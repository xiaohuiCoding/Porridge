//
//  MineViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/6/17.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "MineViewController.h"
#import "ScanViewController.h"
#import "IdentifyViewController.h"
#import "GenerateViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我";
    
    UIButton *scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(DSWidth*3/8,100, DSWidth/4, 30)];
    scanBtn.backgroundColor = [UIColor lightGrayColor];
    [scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    
    UIButton *identifyBtn = [[UIButton alloc] initWithFrame:CGRectMake(DSWidth*3/8,200, DSWidth/4, 30)];
    identifyBtn.backgroundColor = [UIColor lightGrayColor];
    [identifyBtn setTitle:@"识别" forState:UIControlStateNormal];
    [identifyBtn addTarget:self action:@selector(identifyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:identifyBtn];
    
    UIButton *generateBtn = [[UIButton alloc] initWithFrame:CGRectMake(DSWidth*3/8,300, DSWidth/4, 30)];
    generateBtn.backgroundColor = [UIColor lightGrayColor];
    [generateBtn setTitle:@"生成" forState:UIControlStateNormal];
    [generateBtn addTarget:self action:@selector(generateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:generateBtn];
}

- (void)scanBtnClicked
{
    ScanViewController *scanVC = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:scanVC animated:YES];
}

- (void)identifyBtnClicked
{
    IdentifyViewController *identifyVC = [[IdentifyViewController alloc] init];
    [self.navigationController pushViewController:identifyVC animated:YES];
}

- (void)generateBtnClicked
{
    GenerateViewController *generateVC = [[GenerateViewController alloc] init];
    [self.navigationController pushViewController:generateVC animated:YES];
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
