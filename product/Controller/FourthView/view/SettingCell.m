//
//  SettingCell.m
//  product
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "SettingCell.h"
#import "MoreViewController.h"
@implementation SettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        self.backgroundColor = [UIColor lightGrayColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self makeSubviews];
    }
    return self;
}
- (void)makeSubviews{
    
    // topView
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topView];
    // 给topView添加子控件
    UILabel *leftLabel1 = [[UILabel alloc]init];
    UILabel *leftLabel2 = [[UILabel alloc]init];
    UILabel *middleLabel1 = [[UILabel alloc]init];
    UILabel *middleLabel2 = [[UILabel alloc]init];
    UILabel *rightLabel1 = [[UILabel alloc]init];
    UILabel *rightLabel2 = [[UILabel alloc]init];
    leftLabel1.textAlignment = NSTextAlignmentCenter;
    middleLabel1.textAlignment = NSTextAlignmentCenter;
    rightLabel1.textAlignment = NSTextAlignmentCenter;
    leftLabel1.text = @"10";
    leftLabel1.textColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.5];
    leftLabel1.font = [UIFont systemFontOfSize:30];
    middleLabel1.text = @"20";
    middleLabel1.textColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.5];
    middleLabel1.font = [UIFont systemFontOfSize:30];
    rightLabel1.text = @"8";
    rightLabel1.textColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.5];
    rightLabel1.font = [UIFont systemFontOfSize:30];
    leftLabel2.textAlignment = NSTextAlignmentCenter;
    leftLabel2.textColor = [UIColor grayColor];
    leftLabel2.text = @"已经使用";
    middleLabel2.textAlignment = NSTextAlignmentCenter;
    middleLabel2.textColor = [UIColor grayColor];
    middleLabel2.text = @"微博转发";
    rightLabel2.textAlignment = NSTextAlignmentCenter;
    rightLabel2.textColor = [UIColor grayColor];
    rightLabel2.text = @"正在记录";
    [topView addSubview:leftLabel1];
    [topView addSubview:leftLabel2];
    [topView addSubview:middleLabel1];
    [topView addSubview:middleLabel2];
    [topView addSubview:rightLabel1];
    [topView addSubview:rightLabel2];
    
    //  middleView
    UIView * middleView = [[UIView alloc]init];
    [self.contentView addSubview:middleView];
    UIButton * leftButton = [[UIButton alloc]init];
    UIButton * middleButton = [[UIButton alloc]init];
    UIButton * rightButton = [[UIButton alloc]init];
    // 设置leftButton
    leftButton.layer.borderWidth = 1;
    leftButton.layer.cornerRadius = 5;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.8, 0.8, 0.9, 1 });
    leftButton.layer.borderColor = colorref;//边框颜色
    [leftButton setTitle:@"金币排行榜" forState:UIControlStateNormal];
    [leftButton setBackgroundColor:[UIColor lightGrayColor]];
    leftButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [leftButton setTitleColor:[UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.5] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(goldCoinList) forControlEvents:UIControlEventTouchUpInside];
    // 设置middleButton
    middleButton.layer.borderWidth = 1;
    middleButton.layer.cornerRadius = 5;
    middleButton.layer.borderColor = colorref;
    [middleButton setTitle:@"设置" forState:UIControlStateNormal];
    [middleButton setBackgroundColor:[UIColor lightGrayColor]];
    [middleButton setTitleColor:[UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.5] forState:UIControlStateNormal];
    [middleButton addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    // 设置rightButton
//    rightButton.layer.cornerRadius = 5;
//    rightButton.layer.borderWidth = 1;
//    rightButton.layer.borderColor = colorref;
//    [rightButton setTitle:@"升级" forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(upDate) forControlEvents:UIControlEventTouchUpInside];
//    [rightButton setTitleColor:[UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.5] forState:UIControlStateNormal];
    
    [middleView addSubview:leftButton];
    [middleView addSubview:middleButton];
    [middleView addSubview:rightButton];
    
    // bottomView
    UIView * bottomView = [[UIView alloc]init];
    [self.contentView addSubview:bottomView];
    UIButton * dateCalculateButton = [[UIButton alloc]init];

    UIButton * calendarButton = [[UIButton alloc]init];
    //dateCalculateButton
    [dateCalculateButton setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [dateCalculateButton addTarget:self action:@selector(dateCalculate) forControlEvents:UIControlEventTouchUpInside];
    dateCalculateButton.layer.cornerRadius = 5;
    dateCalculateButton.layer.masksToBounds = YES;
    //calendarButton
    [calendarButton setBackgroundImage:[UIImage imageNamed:@"calendar.jpg"] forState:UIControlStateNormal];
    [calendarButton addTarget:self action:@selector(lookCalendar) forControlEvents:UIControlEventTouchUpInside];
    calendarButton.layer.cornerRadius = 5;
    calendarButton.layer.masksToBounds= YES;
    [bottomView addSubview:dateCalculateButton];
    [bottomView addSubview:calendarButton];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.left.equalTo(self.contentView.left);
        make.right.equalTo(self.contentView.right);
        //        make.height.equalTo(@(60));
        make.height.equalTo(self.contentView.height).multipliedBy(60.0/180);
    }];
    [leftLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(10);
        make.top.equalTo(topView.top);
        make.right.equalTo(middleLabel1.left);
        make.width.equalTo(middleLabel1.width);
        //        make.height.equalTo(@(30));
        make.height.equalTo(topView.height).multipliedBy(0.5);
    }];
    [middleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.top);
        make.width.equalTo(rightLabel1.width);
        make.right.equalTo(rightLabel1.left);
        make.height.equalTo(leftLabel1.height);
    }];
    [rightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.top);
        make.width.equalTo(leftLabel1.width);
        make.right.equalTo(topView.mas_right).offset(-10);
        make.height.equalTo(middleLabel1.height);
    }];
    
    [leftLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLabel1.bottom);
        make.left.equalTo(topView.mas_left).offset(10);
        make.right.equalTo(middleLabel2.left);
        make.width.equalTo(middleLabel2.width);
        //        make.height.equalTo(@(20));
        make.height.equalTo(topView.height).multipliedBy(20.0/60);
    }];
    [middleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleLabel1.bottom);
        make.width.equalTo(rightLabel2.width);
        make.right.equalTo(rightLabel2.left);
        make.height.equalTo(leftLabel2.height);
    }];
    [rightLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightLabel1.bottom);
        make.width.equalTo(leftLabel2.width);
        make.right.equalTo(topView.mas_right).offset(-10);
        make.height.equalTo(leftLabel2.height);
    }];
    
    
//    // middleView
//    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(topView.bottom);
//        make.left.equalTo(self.contentView.left);
//        make.width.equalTo(self.contentView.width);
//        //        make.height.equalTo(@(30));
//        make.height.equalTo(self.contentView.height).multipliedBy(30.0/210);
//    }];
////    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(middleView.mas_left).offset(30);
////        make.top.equalTo(middleView.top);
////        make.bottom.equalTo(middleView.bottom);
////        make.right.equalTo(middleButton.mas_left).offset(-10);
////        make.width.equalTo(middleButton.width);
////    }];
//    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(middleView.mas_left).offset(70);
//        make.top.equalTo(middleView.top);
//        make.bottom.equalTo(middleView.bottom);
//        make.right.equalTo(middleButton.mas_left).offset(-20);
//        make.width.equalTo(middleButton.width);
//    }];
////    [middleButton mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.equalTo(middleView.top);
////        make.height.equalTo(leftButton.height);
////        make.right.equalTo(rightButton.mas_left).offset(-10);
////        make.width.equalTo(rightButton.width);
////    }];
//    [middleButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(middleView.top);
//        make.height.equalTo(leftButton.height);
//        make.right.equalTo(middleView.mas_right).offset(-70);
////        make.width.equalTo(rightButton.width);
//    }];
////    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.equalTo(middleView.top);
////        make.right.equalTo(middleView.mas_right).offset(-30);
////        make.height.equalTo(leftButton.height);
////    }];
    
    // bottomView
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.bottom);
        make.left.equalTo(self.contentView.left);
        make.right.equalTo(self.contentView.right);
        make.bottom.equalTo(self.contentView.bottom);
    }];
    [dateCalculateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(5);
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.right.equalTo(calendarButton.mas_left).offset(-30);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-5);
        make.width.equalTo(calendarButton.width);
    }];
    [calendarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dateCalculateButton.top);
        make.right.equalTo(bottomView.mas_right).offset(-20);
        make.height.equalTo(dateCalculateButton.height);
    }];
    
}
- (void)lookCalendar{
    
    [self.delegate lookCalendar];
}
// 进入设置界面
- (void)setting{

    [self.delegate setting];
}
// 跳转到日期计算器
-(void)dateCalculate{

    [self.delegate dateCalculate];
}
// 跳到更新页面
- (void)upDate{
    
    [self.delegate upDate];
//    NSLog(@"=====");
}
// 进入金币排行榜界面
- (void)goldCoinList{

    [self.delegate goldCoinList];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


