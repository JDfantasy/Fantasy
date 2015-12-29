//
//  SecCell.m
//  product
//
//  Created by JD -高 on 15/7/30.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "SecCell.h"

@implementation SecCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel * label = [[UILabel alloc]init];
        label.textColor = [UIColor colorWithRed: 0 green: 0.9064 blue: 1 alpha: 1.0];
        label.font = [UIFont boldSystemFontOfSize:17];
        label.text = @"午休是世界上最幸福的事情,没有之一!";
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.left).offset(30);
            make.right.equalTo(self.contentView.right).offset(-30);
            make.top.equalTo(self.contentView.top).offset(5);
            make.bottom.equalTo(self.contentView.bottom).offset(-5);
        }];
    }
    return self;
}

@end
