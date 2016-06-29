//
//  macro.h
//  demo1
//
//  Created by 冯小辉 on 16/3/31.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#ifndef macro_h
#define macro_h

//设备屏幕的宽和高
#define DSWidth [[UIScreen mainScreen] bounds].size.width
#define DSHeight [[UIScreen mainScreen] bounds].size.height

//用户引导页展示与否的标识
#define User_Guided @"isGuided"

//广告图片名
#define AdImageName @"adImageName"

//用户默认存储，用来保存轻量级数据
#define kNSUserDefaults [NSUserDefaults standardUserDefaults]

#endif /* macro_h */
