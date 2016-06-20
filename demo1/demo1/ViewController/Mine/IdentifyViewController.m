//
//  IdentifyViewController.m
//  demo1
//
//  Created by 冯小辉 on 16/5/19.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "IdentifyViewController.h"

@interface IdentifyViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation IdentifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"识别二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(DSWidth*3/8,200, DSWidth/4, 30)];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"相册" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClicked
{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoPicker.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:photoPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *srcImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *image = [CIImage imageWithCGImage:srcImage.CGImage];
    NSArray *featureArray = [detector featuresInImage:image];
    CIQRCodeFeature *feature = [featureArray firstObject];
    
    NSString *result = feature.messageString;
    if (result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
    }
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
