//
//  FourthViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/3/25.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tabView;
    NSMutableArray *dataArray;
}

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"fourth";
    
    dataArray = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    tabView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    tabView.dataSource = self;
    tabView.delegate = self;
    tabView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tabView];
    
    [self addObserver:self forKeyPath:@"tbVContentOffSetY" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    NSLog(@"y轴偏移量初始值：%f",tabView.contentOffset.y);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = dataArray[indexPath.row];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.navigationItem.title = @"scroll了";
    self.tbVContentOffSetY = tabView.contentOffset.y;
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    self.navigationItem.title = @"no scroll";
//    self.tbVContentOffSetY = tabView.contentOffset.y;
//}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.navigationItem.title = @"第四页";
    self.tbVContentOffSetY = tabView.contentOffset.y;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"tbVContentOffSetY"]) {
        NSLog(@"y轴偏移量：%f",[change[@"new"] floatValue]);
    }
}

//数据库操作
- (void)DBOperation
{
    //FMDB的使用
    
//    //1.指定数据库文件路径
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.db"];
//    
//    //2.用指定的路径初始化数据库对象
//    FMDatabase *_db = [[FMDatabase alloc] initWithPath:path];
//    BOOL result0 = [_db open];
//    if (result0 == NO) {
//        NSLog(@"数据库打开失败！");
//        return;
//    }
    
    
    //        //创建表
    //        result0 = [_db executeUpdate:@"create table if not exists USER(id integer primary key autoincrement,name,score,image)"];
    //        //关闭数据库
    //        [_db close];
    //
    //
    //        //a.插入
    //        //FMDB支持类型：NSString,NSNumber,NSData,将数据转化为能够存储进数据库的类型
    //        NSString *name = @"小辉";
    //        NSNumber *score = [NSNumber numberWithInt:[@"100" intValue]];
    //        NSData *imageData = nil;
    //        BOOL result = [_db open];
    //        if (result == NO) {
    //            NSLog(@"数据库打开失败！");
    //            return;
    //        }
    //        result = [_db executeUpdate:@"insert into USER(name,score,image) values(?,?,?)",name,score,imageData];
    //        if (result == NO) {
    //            NSLog(@"插入失败！");
    //        }
    //        [_db close];
    //
    //
    //        //b.删除
    //        BOOL result2 = [_db open];
    //        if (result2 == NO) {
    //            NSLog(@"数据库打开失败！");
    //            return;
    //        }
    //        result2 = [_db executeUpdate:@"delete from USER where name=?",@"小辉"];
    //        if (result2 == NO) {
    //            NSLog(@"删除失败！");
    //        }
    //        [_db close];
    
    
    //    //c.更新
    //    BOOL result3 = [_db open];
    //    if (result3 == NO) {
    //        NSLog(@"数据库打开失败！");
    //        return;
    //    }
    //    result3 = [_db executeUpdate:@"update USER set score=? where name=?",[NSNumber numberWithInt:100],@"小辉"];
    //    //result3 = [_db executeUpdate:@"update USER set score=? where id=?",[NSNumber numberWithInt:100],@4];
    //    if (result3 == NO) {
    //        NSLog(@"更新失败！");
    //    }
    //    [_db close];
    
    
    //    //d.查询
    //    BOOL result4 = [_db open];
    //    if (result4 == NO) {
    //        NSLog(@"数据库打开失败！");
    //        return;
    //    }
    //    FMResultSet *set = [_db executeQuery:@"select * from USER"];
    //    while ([set next]) {
    //        //取值
    //        NSString *name = [set stringForColumn:@"name"];
    //        int score = [set intForColumn:@"score"];
    //        NSData *data = [set dataForColumn:@"image"];
    //        NSLog(@"%@ %d %@",name,score,data);
    //    }
    //    [_db close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
