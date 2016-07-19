//
//  MyLabel.h
//  Test
//
//  Created by DMC on 14-2-20.
//  Copyright (c) 2014年 DMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLabel : UILabel
{
@private
    CGFloat characterSpacing_;       //字间距
    long    linesSpacing_;           //行间距
}
@property(nonatomic,assign) CGFloat characterSpacing;
@property(nonatomic,assign) long    linesSpacing;

/*
 *绘制前获取label高度
 */
- (int)getAttributedStringHeightWidthValue:(int)width;

@end
/*
 MyLabel *readNewsLable =[[MyLabel alloc] initWithFrame:CGRectZero];
 readNewsLable.textColor =[UIColor redColor];
 readNewsLable.lineBreakMode = NSLineBreakByCharWrapping;
 readNewsLable.backgroundColor = [UIColor greenColor];
 readNewsLable.font = [UIFont systemFontOfSize:15];
 [readNewsLable setText:@"1、啊啊\r  啊啊啊啊啊啊啊啊啊!啊啊?啊啊啊啊啊啊啊,啊啊啊啊啊啊啊啊啊啊啊啊\n    333啊啊啊啊啊啊aaaa33333333333啊啊啊啊啊啊,!啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊2333333333333333333333啊啊啊啊啊3333啊啊啊12312312啊啊啊啊问123123啊大大大33123123213请问啊啊大大大三大大声地"];
// 设置label的frame值
readNewsLable.frame =  CGRectMake(0, 0, 320, [readNewsLable getAttributedStringHeightWidthValue:320]) ;
readNewsLable.numberOfLines = 0;
readNewsLable.linesSpacing = 10.0f;
readNewsLable.characterSpacing = 5.0f;

 */