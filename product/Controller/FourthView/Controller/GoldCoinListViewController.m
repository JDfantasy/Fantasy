//
//  GoldCoinListViewController.m
//  product
//
//  Created by 谭永钊 on 15/8/1.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "GoldCoinListViewController.h"

@interface GoldCoinListViewController ()

@end

@implementation GoldCoinListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"金币排行榜";
    [self setupSubviews];
}

- (void)setupSubviews{


    UILabel * label = [[UILabel alloc]init];
    label.text = @"敬请期待";
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(200);
        make.left.equalTo(self.view.mas_left).offset(100);
        make.right.equalTo(self.view.mas_right).offset(-100);
        make.height.equalTo(@(30));
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
