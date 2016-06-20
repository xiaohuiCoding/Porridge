//
//  ViewControllerDetailNext.m
//  demo1
//
//  Created by 冯小辉 on 16/3/31.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "ViewControllerDetailNext.h"

@interface ViewControllerDetailNext ()

@property(nonatomic,  copy)NSString *cStr;
@property(nonatomic,retain)NSString *rStr;

@end

@implementation ViewControllerDetailNext

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(returnBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    //声明属性时使用关键字copy与retain的区别
    NSMutableString *str = [NSMutableString stringWithFormat:@"abc"];
    self.cStr = str;
    self.rStr = str;
    NSLog(@"str:%@ %p",str,&str);
    NSLog(@"copy   string:%@ %p",_cStr,&_cStr);
    NSLog(@"retain string:%@ %p",_rStr,&_rStr);
    
    [str appendString:@"de"];
    NSLog(@"%@",_cStr);
    NSLog(@"%@",_rStr);
}

- (void)returnBack
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
