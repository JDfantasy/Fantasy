//
//  ZheXianCell.m
//  product
//
//  Created by qianfeng on 15/8/2.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "ZheXianCell.h"
#import "CellView.h"

@implementation ZheXianCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CellView * view = [[CellView alloc]init];
        [self.contentView addSubview:view];
        view.backgroundColor = [UIColor colorWithRed:0.785 green:1.000 blue:0.933 alpha:1.000];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(arc4random()%70+20);
            make.right.equalTo(self.right).offset(-1);
            make.top.equalTo(self.top).offset(10);
            make.height.equalTo(20);
        }];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
