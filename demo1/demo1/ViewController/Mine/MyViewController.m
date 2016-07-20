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
}
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我";
    
    sectionArray = [NSArray arrayWithObjects:@"我的订单",@"我的抽奖记录",@"我的发布",@"我的消息",@"充值记录",@"推荐好友",@"设置",@"关于我们", nil];
    leftImageArray = [NSArray arrayWithObjects:@"My_order",@"My_prize",@"My_fabu",@"My_message",@"My_chongzhi",@"My_share",@"My_setting",@"My_about", nil];
    
    tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DSWidth, DSHeight-64-49) style:UITableViewStylePlain];
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabView.showsVerticalScrollIndicator = NO;
    tabView.bounces = NO;
    tabView.delegate = self;
    tabView.dataSource = self;
    [self.view addSubview:tabView];
    
    [self initHeaderView];
}

- (void)initHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DSWidth, 161)];
    headerView.backgroundColor = [UIColor purpleColor];
    tabView.tableHeaderView = headerView;
    
    photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
    photoImageView.layer.cornerRadius = 35;
    photoImageView.layer.masksToBounds = YES;
    [photoImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    photoImageView.userInteractionEnabled = YES;
    [headerView addSubview:photoImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkPhoto)];
    [photoImageView addGestureRecognizer:tap];
    
    //nickNameLb = [XHObject ]
}

- (void)checkPhoto
{
    
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
