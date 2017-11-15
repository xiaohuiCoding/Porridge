//
//  HomeViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/6/17.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "HomeViewController.h"
#import "AdvertiseDetailViewController.h"
#import "ScanViewController.h"
#import "ViewControllerDetail.h"
#import "Weather.h"
#import "XHObserver.h"
#import "MyLabel.h"
#import <Crashlytics/Crashlytics.h>

@interface HomeViewController ()<SDCycleScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    XHObserver *observer;
    UILabel *lb;
    UILabel *txtLb;
}
@end

@implementation HomeViewController

- (void)dealloc
{
    //移除观察者
    [observer removeObserver:self forKeyPath:@"score"];
    
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)crashButtonTapped:(id)sender {
    [[Crashlytics sharedInstance] crash];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(120, 200, 100, 30);
    [button setTitle:@"Crash" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(crashButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    
    //监听广告图被点击了
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAdvertiseDetailPage) name:@"pushToAdvertiseDetail" object:nil];
    
    
    self.navigationItem.title = @"首页";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_bar_scan"] style:UIBarButtonItemStylePlain target:self action:@selector(scan)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    /*********************三方轮播图**********************/
    
    //本地图片请填写全名
    NSArray *imageNameArray = @[@"h1.jpg",@"h2.jpg",@"h3.jpg",@"h4.jpg"];
    //本地加载图片的轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, DSWidth, DSHeight/4) imageNamesGroup:imageNameArray];
    cycleScrollView.delegate = self;
    [self.view addSubview:cycleScrollView];
    //避免轮播图顶部出现空白区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    /*********************KVO的使用**********************/
    
    //1.自己观察自己
    observer = [[XHObserver alloc] init];
    //给属性赋初值
    [observer setValue:@"小辉" forKey:@"name"];
    [observer setValue:@"80.0" forKey:@"score"];
    //添加观察者
    [observer addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    lb = [[UILabel alloc] initWithFrame:CGRectMake(DSWidth/8, 64 + DSHeight/4 + 10, DSWidth/4, 30)];
    lb.backgroundColor = [UIColor lightGrayColor];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = [NSString stringWithFormat:@"%.1f",[[observer valueForKey:@"score"] floatValue]];
    [self.view addSubview:lb];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(DSWidth*5/8, 64 + DSHeight/4 + 10, DSWidth/4, 30)];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"KVO" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //2.别人观察自己
    Weather *w = [[Weather alloc] init];
    //给属性赋初值
    [w setValue:@"杭州市" forKey:@"cityName"];
    [w setValue:@"26.0" forKey:@"temperature"];
    XHObserver *s = [[XHObserver alloc] init];
    //添加观察者
    [w addObserver:s forKeyPath:@"temperature" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    //更改属性值
    [w setValue:@"18.0" forKey:@"temperature"];
    //移除观察者
    [w removeObserver:s forKeyPath:@"temperature"];
    
    
    /*********************通知的使用**********************/
    
    //1.监听系统自带的Notification
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(DSWidth/8, 64 + DSHeight/4 + 54, DSWidth*3/4, 30)];
    tf.backgroundColor = [UIColor lightGrayColor];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.placeholder = @"系统自带的Notification：";
    [self.view addSubview:tf];
    
    //在通知中心注册键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUpEvent:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDownEvent:) name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
    //2.自定义通知
    UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(DSWidth/8, 64 + DSHeight/4 + 94, DSWidth/2, 30)];
    [changeBtn setTitle:@"自定义的Notification" forState:UIControlStateNormal];
    changeBtn.backgroundColor = [UIColor lightGrayColor];
    [changeBtn addTarget:self action:@selector(changeText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    
    txtLb = [[UILabel alloc] initWithFrame:CGRectMake(DSWidth*11/16, 64 + DSHeight/4 + 94, DSWidth/4, 30)];
    txtLb.backgroundColor = [UIColor lightGrayColor];
    txtLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:txtLb];
    
    //本类注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptChange:) name:@"noti_name" object:nil];
    
    
     MyLabel *readNewsLable =[[MyLabel alloc] initWithFrame:CGRectZero];
     readNewsLable.textColor =[UIColor redColor];
     readNewsLable.lineBreakMode = NSLineBreakByCharWrapping;
     readNewsLable.backgroundColor = [UIColor greenColor];
     readNewsLable.font = [UIFont systemFontOfSize:15];
     [readNewsLable setText:@"啊啊啊啊啊啊啊啊啊啊啊!啊啊?啊啊啊啊啊啊啊,啊啊啊啊啊啊啊啊啊啊啊啊333啊啊啊啊啊啊aaaa33333333333啊啊啊啊啊啊,!啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊2333333333333333333333啊啊啊啊啊3333啊啊啊12312312啊啊啊啊问123123啊大大大33123123213请问啊啊大大大三大大声地"];
     // 设置label的frame值
     readNewsLable.frame =  CGRectMake(0, 300, 320, [readNewsLable getAttributedStringHeightWidthValue:320]) ;
     readNewsLable.numberOfLines = 0;
     readNewsLable.linesSpacing = 10.0f;
     readNewsLable.characterSpacing = 5.0f;
    [self.view addSubview:readNewsLable];
    
    //自适应文本展示
    //[self autoText];
}

- (void)pushToAdvertiseDetailPage
{
    AdvertiseDetailViewController *advertiseDetailVC = [[AdvertiseDetailViewController alloc] init];
    advertiseDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:advertiseDetailVC animated:YES];
}

//扫描
- (void)scan
{
//    @weakify(self)
    [LWPrivacyUtils requestCameraPermission:^(BOOL granted) {
//        @strongify(self)
        if (granted) {
            ScanViewController *scanVC = [[ScanViewController alloc] init];
            scanVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:scanVC animated:YES];
        }
        
    } isShowAlertView:YES];
}

//搜索
- (void)search
{
    [self setAvatar];
}

- (void)setAvatar
{
//    @weakify(self)
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil cancelButtonItem:[RIButtonItem itemWithLabel:NSLocalizedString(@"取消", @"取消")] destructiveButtonItem:nil otherButtonItems:[RIButtonItem itemWithLabel:NSLocalizedString(@"拍照", @"拍照") action:^{
//        @strongify(self)
        [self takePhotoWithSourceType:UIImagePickerControllerSourceTypeCamera];
        
    }], [RIButtonItem itemWithLabel:NSLocalizedString(@"从相册中选取", @"从相册中选取") action:^{
//        @strongify(self)
        [self takePhotoWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }], nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)takePhotoWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
//    @weakify(self)
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        [LWPrivacyUtils requestCameraPermission:^(BOOL granted) {
//            @strongify(self)
            if (granted) {
                [self showImagePickerControllerWithSourceType:sourceType];
            }
            
        } isShowAlertView:YES];
    } else if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        [LWPrivacyUtils requestPhotoPermission:^(BOOL isDetermined) {
            if (isDetermined) {
                [self showImagePickerControllerWithSourceType:sourceType];
            }
        } isShowAlertView:YES];
    }
}

- (void)showImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = sourceType;
    controller.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
    controller.allowsEditing = YES;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSArray *arr = @[@"http://www.iqiyi.com/",@"http://www.taobao.com/",@"http://www.jd.com/",@"http://www.sina.com/"];
    ViewControllerDetail *vcDetail = [[ViewControllerDetail alloc] init];
    vcDetail.urlString = arr[index];
    vcDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcDetail animated:YES];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    NSLog(@"%@",[NSString stringWithFormat:@"%ld/3",(long)index]);
}

//更改属性值
- (void)changeValue
{
    [observer setValue:@"90.0" forKey:@"score"];
    [observer setValue:@"100.0" forKey:@"score"];
}

//调用监听的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"score"]) {
        
        //虽然最终只显示最后赋的值，但属性变化的全过程都被打印(监听)了！
        NSLog(@"old score is：%.1f, new score is：%.1f",[change[@"old"] floatValue],[change[@"new"] floatValue]);
        
        //接收属性值变更通知
        lb.text = [NSString stringWithFormat:@"%.1f",[[observer valueForKey:@"score"] floatValue]];
        lb.backgroundColor = [UIColor blueColor];
    }
}

//键盘弹出事件触发处理
- (void)keyboardUpEvent:(NSNotification *)notification
{
    NSLog(@"键盘弹出事件触发！");
}

- (void)keyboardDownEvent:(NSNotification *)notification
{
    NSLog(@"键盘隐藏事件触发！");
}

- (void)becomeActive:(NSNotification *)notification
{
    NSLog(@"程序从后台唤醒事件触发！");
}

- (void)changeText
{
    //通知中心发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noti_name" object:nil userInfo:@{@"text":@"change"}];
}

- (void)acceptChange:(NSNotification *)notification
{
    txtLb.text = notification.userInfo[@"text"];
    txtLb.backgroundColor = [UIColor redColor];
}

- (void)autoText
{
    NSString *text = @"创建串行队列&并发队列当我们需要某些任务以指定的顺序去执行时，串行队列是一个非常好的选择。一个串行队列在同一时间里只会执行一个任务，而且每次都只会从队列的头部把任务取出来执行。正因为如此，我们可以用串行队列来替代锁的操作，比如数据资源的同步或修改数据结构时。和锁不同的是，串行队列能保证任务都是在可预见的顺序里执行，而且一旦我们在一个串行队列里异步提交了任务，队列就能永远不发生死锁。怎么样，是不是很棒，不过不像并发队列，这些串行队列是需要我们自己创建和管理的。我们还可以在程序里创建任意数量的队列，不过值得注意的是，我们要尽量避免创建大量的串行队列而目的仅仅是为了同时执行队列中的这些任务。虽然GCD通过创建所谓的线程池来大致匹配CPU内核数量，但是线程的创建并不是无代价的。每个线程都需要占用内存和内核资源。所以如果需要创建大量的并发任务，我们只需要把这些任务放到并发队列中即可。";
    
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(DSWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    
    UILabel *textLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + DSHeight/4 + 134, DSWidth, rectToFit.size.height)];
    textLb.backgroundColor = [UIColor greenColor];
    textLb.text = text;
    textLb.font = [UIFont systemFontOfSize:12.0];
    textLb.numberOfLines = 0;
    [self.view addSubview:textLb];
}

////隐藏状态栏（视图控制器默认可调用的方法）
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
