//
//  CountManagerViewController.m
//  app_mechanics
//
//  Created by liujingyu on 15/7/24.
//  Copyright (c) 2015年 vincent. All rights reserved.
//

#import "CountManagerViewController.h"

@interface CountManagerViewController ()

@end

@implementation CountManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"账号管理";
    
    UILabel * label1 = [[UILabel alloc] init];
    label1.text = @"如果您不是32枚金币的会员，请注册！";
    label1.adjustsFontSizeToFitWidth = YES;
    
    UILabel * label2 = [[UILabel alloc] init];
    label2.text = @"   登陆";
    label2.textAlignment = NSTextAlignmentLeft;
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weidu.png"]];
    label2.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    label2.layer.borderWidth = 1;
    label2.layer.cornerRadius = 5;
    [label2 addSubview:imageView];
    
    UILabel * label3 = [[UILabel alloc] init];
    label3.text = @"   注册";
    label3.textAlignment = NSTextAlignmentLeft;
    UIImageView * imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weidu.png"]];
    label3.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    label3.layer.borderWidth = 1;
    label3.layer.cornerRadius = 5;
    [label3 addSubview:imageView1];
    
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:label3];

    
    [label1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.equalTo(self.view.mas_left).offset(60);
        make.right.equalTo(self.view.mas_right).offset(-60);
        make.height.equalTo(@20);
    }];
    
    [label2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(40);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.equalTo(@40);
    }];
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_top).offset(11);
        make.width.equalTo(@20);
        make.right.equalTo(label2.mas_right).offset(-5);
        make.bottom.equalTo(label2.mas_bottom).offset(-11);
    }];
    
    [label3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(25);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.equalTo(@40);
    }];
    
    [imageView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_top).offset(11);
        make.width.equalTo(@20);
        make.right.equalTo(label3.mas_right).offset(-5);
        make.bottom.equalTo(label3.mas_bottom).offset(-11);
    }];
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
