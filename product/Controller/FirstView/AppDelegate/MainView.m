//
//  MainView.m
//  product
//
//  Created by qianfeng on 15/8/2.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "MainView.h"
#import "DaBingView.h"
#import "RightUpView.h"
#import "RightDownView.h"
#import "MainView.h"
#import "ZheXianView.h"
#import "ZheXianCell.h"

@interface MainView ()<UITableViewDelegate , UITableViewDataSource>

{
    BOOL Open;
    BOOL temp;
    NSInteger temp_Height;
}
@end


@implementation MainView

- (instancetype)init{

    if (self = [super init]) {
        //    主大饼!!
        DaBingView *  daBingView = [[DaBingView alloc]init];
        [self addSubview:daBingView];
        daBingView.layer.masksToBounds = YES;
        daBingView.layer.cornerRadius  = 75;
        [daBingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(10);
            make.right.equalTo(self.left).offset(160);
            make.top.equalTo(self.top).offset(45);
            make.height.equalTo(150);
        }];
        
        UILabel * label = [WHController labelWithFrame:CGRectNull andFont:50.0f andtext:@"32"];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:50.0f];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(daBingView.left).offset(40);
            make.right.equalTo(daBingView.right).offset(-40);
            make.top.equalTo(daBingView.top).offset(50);
            make.bottom.equalTo(daBingView.bottom).offset(-55);
        }];
        
        UILabel * labelNum = [WHController labelWithFrame:CGRectNull andFont:15.0f andtext:@"GOLDS"];
        labelNum.font = [UIFont boldSystemFontOfSize:15.0f];
        labelNum.textColor = [UIColor colorWithWhite:0.990 alpha:0.800];
        labelNum.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelNum];
        [labelNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.left).offset(5);
            make.right.equalTo(label.right).offset(-5);
            make.top.equalTo(label.bottom).offset(0);
            make.bottom.equalTo(label.bottom).offset(20);
        }];
        
        
        //    右上边的大饼
        RightUpView *  rightUpView = [[RightUpView alloc]init];
        [self addSubview:rightUpView];
        rightUpView.layer.masksToBounds = YES;
        rightUpView.layer.cornerRadius  = 50;
        [rightUpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(daBingView.right).offset(0);
            make.right.equalTo(daBingView.right).offset(100);
            make.top.equalTo(daBingView.top).offset(-50);
            make.height.equalTo(100);
        }];
        
        UILabel * labelRU = [WHController labelWithFrame:CGRectNull andFont:25.0f andtext:@"25"];
        labelRU.textColor = [UIColor whiteColor];
        labelRU.font = [UIFont boldSystemFontOfSize:25];
        labelRU.textAlignment = NSTextAlignmentCenter;
        [rightUpView addSubview:labelRU];
        [labelRU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightUpView.left).offset(20);
            make.right.equalTo(rightUpView.right).offset(-20);
            make.top.equalTo(rightUpView.top).offset(30);
            make.bottom.equalTo(rightUpView.bottom).offset(-40);
        }];
        
        UILabel * labelRUNum = [WHController labelWithFrame:CGRectNull andFont:13.0f andtext:@"NotDown"];
        labelRUNum.font = [UIFont boldSystemFontOfSize:13.0f];
        labelRUNum.textColor = [UIColor colorWithWhite:0.990 alpha:0.800];
        labelRUNum.textAlignment = NSTextAlignmentCenter;
        [rightUpView addSubview:labelRUNum];
        [labelRUNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelRU.left).offset(0);
            make.right.equalTo(labelRU.right).offset(0);
            make.top.equalTo(labelRU.bottom).offset(-5);
            make.height.equalTo(20);
        }];
        
        //    下面的View
        RightDownView *  rightDownView = [[RightDownView alloc]init];
        [self addSubview:rightDownView];
//        rightDownView.backgroundColor = [UIColor blueColor];
        rightDownView.layer.masksToBounds = YES;
        rightDownView.layer.cornerRadius  = 65;
        [rightDownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(daBingView.right).offset(-40);
            make.right.equalTo(daBingView.right).offset(90);
            make.top.equalTo(daBingView.bottom).offset(-10);
            make.height.equalTo(130);
        }];
        
        UILabel * labelDown = [WHController labelWithFrame:CGRectNull andFont:40.0f andtext:@"15"];
        labelDown.textColor = [UIColor whiteColor];
        labelDown.font = [UIFont boldSystemFontOfSize:40];
        labelDown.textAlignment = NSTextAlignmentCenter;
        [rightDownView addSubview:labelDown];
        [labelDown mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightDownView.left).offset(20);
            make.right.equalTo(rightDownView.right).offset(-20);
            make.top.equalTo(rightDownView.top).offset(30);
            make.bottom.equalTo(rightDownView.bottom).offset(-50);
        }];
    
        UILabel * labelDNum = [WHController labelWithFrame:CGRectNull andFont:17.0f andtext:@"Game"];
        labelDNum.font = [UIFont boldSystemFontOfSize:17.0f];
        labelDNum.textColor = [UIColor colorWithWhite:0.990 alpha:0.800];
        labelDNum.textAlignment = NSTextAlignmentCenter;
        [rightDownView addSubview:labelDNum];
        [labelDNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelDown.left).offset(0);
            make.right.equalTo(labelDown.right).offset(0);
            make.top.equalTo(labelDown.bottom).offset(0);
            make.height.equalTo(10);
        }];
        
        //    折线图
        ZheXianView * viewTab = [[ZheXianView alloc]initWithFrame:CGRectMake(60, HEIGHT - 330, 150, 220)];
        viewTab.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.000];
        [self addSubview:viewTab];
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(60, HEIGHT - 330, 150, 215) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:tableView];
        //    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(viewTab.left).offset(0);
        //        make.right.equalTo(viewTab.right).offset(0);
        //        make.top.equalTo(viewTab.top).offset(0);
        //        make.bottom.equalTo(viewTab.bottom).offset(0);
        //    }];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        viewTab.transform = CGAffineTransformMakeRotation(M_PI/2);
        tableView.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        
        UILabel * labelY = [[UILabel alloc]init];
        labelY.text = @"金币/个";
        labelY.textColor = [UIColor whiteColor];
        labelY.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:labelY];
        [labelY mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(10);
            make.right.equalTo(self.right).offset(60);
            make.top.equalTo(self.top).offset(HEIGHT - 325);
            make.height.equalTo(30);
        }];
        
        UILabel * labelX = [[UILabel alloc]init];
        labelX.text = @"时间/天";
        labelX.textColor = [UIColor whiteColor];
        labelX.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:labelX];
        [labelX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(220);
            make.right.equalTo(self.right).offset(250);
            make.top.equalTo(self.top).offset(HEIGHT - 150);
            make.height.equalTo(30);
        }];

    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    创建多个cell  用不同的 id
    ZheXianCell * cell = [[ZheXianCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = indexPath.row % 2 ? [UIColor colorWithWhite:0.701 alpha:0.200]:[UIColor colorWithRed:0.739 green:1.000 blue:0.969 alpha:0.200];
}



@end
