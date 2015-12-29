//
//  DailyWordCell.m
//  日历界面1
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DailyWordCell.h"
#import "MyControl.h"
@implementation DailyWordCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        self.backgroundColor = [UIColor lightGrayColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self makeSubviews];
    }
    return self;
}
- (void)makeSubviews{
    UIView *view = self.contentView;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed: 0.5723 green: 0.5723 blue: 0.5723 alpha: 0.5].CGColor;

    UILabel * label = [MyControl createLabelWithText:@"每日一言" andTextColor:[UIColor blackColor] andTextAlignment:NSTextAlignmentLeft andbackgroundColor:[UIColor whiteColor] andfont:[UIFont systemFontOfSize:18]];
//    label.text = @"每日一言";
    
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView setImage:[UIImage imageNamed:@"image0.png"]];
    UILabel *wordLabe = [[UILabel alloc]init];
    //图片圆角
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor colorWithRed: 0.5723 green: 0.5723 blue: 0.5723 alpha: 0.5].CGColor;

    
    wordLabe.backgroundColor = [UIColor blackColor];
    wordLabe.alpha = 0.5;
    wordLabe.text = @"  要为别人着想，但要为自己而活";
    wordLabe.textColor = [UIColor whiteColor];
    [imageView addSubview:wordLabe];
    [self.contentView addSubview:label];
    [self.contentView addSubview:imageView];
    
    //--------------约束
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(7);
        make.right.equalTo(self.right).offset(-7);
        make.top.equalTo(self.top).offset(7);
        make.bottom.equalTo(self.bottom).offset(-7);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(self.contentView.height).multipliedBy(0.1);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    [wordLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_left).offset(0);
        make.right.equalTo(imageView.mas_right).offset(0);
        make.bottom.equalTo(imageView.bottom);
        make.height.equalTo(label.height);
    }];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
