//
//  MyCell.m
//  demo1
//
//  Created by 冯小辉 on 16/7/5.
//  Copyright © 2016年 xinguang. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.leftImageView.layer.cornerRadius = 5;
    self.leftImageView.layer.masksToBounds = YES;
    [self addSubview:self.leftImageView];
    
    //self.nameLb = [UILabel alloc] initWithFrame:];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
