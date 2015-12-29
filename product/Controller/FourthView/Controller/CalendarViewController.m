//
//  CalendarViewController.m
//  日历界面
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarTableViewCell.h"
@interface CalendarViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    UITableView * _tableView;
}
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    // 隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:23.0], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.title = @"日历";
  
   
    
    [self addGestureRecognizer];
}
- (void)addGestureRecognizer{

    UISwipeGestureRecognizer * downSwip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(downSwip)];
    downSwip.direction = UISwipeGestureRecognizerDirectionDown;
    [_tableView addGestureRecognizer:downSwip];
}
- (void)downSwip{

//    NSLog(@"===");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.row == 0) {
        static NSString * cellID = @"calendarCell";
        CalendarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CalendarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 550;
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
