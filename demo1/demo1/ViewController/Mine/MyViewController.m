//
//  MyViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/7/1.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *sectionArray;
    NSArray *leftImageArray;
    
    UITableView *tabView;
    UIImageView *photoImageView;
    UILabel     *nickNameLb;
    UILabel     *userNameLb;
    
    UISwitch *mySwitch;
}
@end

@implementation MyViewController

- (void)initHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DSWidth, 160)];
    headerView.backgroundColor = [UIColor purpleColor];
    tabView.tableHeaderView = headerView;
    
    photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [headerView addSubview:photoImageView];
    
    //nickNameLb = [UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"style" style:UIBarButtonItemStylePlain target:self action:@selector(changeStyle)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
//    [mySwitch addTarget:self action:@selector(changeStyle) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:mySwitch];
    
    sectionArray = [NSArray arrayWithObjects:@"我的订单",@"我的抽奖记录",@"我的发布",@"我的消息",@"充值记录",@"推荐好友",@"设置",@"关于我们", nil];
    leftImageArray = [NSArray arrayWithObjects:@"My_order",@"My_prize",@"My_fabu",@"My_message",@"My_chongzhi",@"My_share",@"My_setting",@"My_about", nil];
    
    tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DSWidth, DSHeight-64) style:UITableViewStylePlain];
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabView.showsVerticalScrollIndicator = NO;
    tabView.bounces = NO;
    tabView.delegate = self;
    tabView.dataSource = self;
    [self.view addSubview:tabView];
    
    [self initHeaderView];
}

- (void)changeStyle
{
    if (mySwitch.on) {
        [UIApplication sharedApplication].delegate.window.backgroundColor = [UIColor blackColor];
    }
    else {
        [UIApplication sharedApplication].delegate.window.backgroundColor = [UIColor whiteColor];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return sectionArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return nil;
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
