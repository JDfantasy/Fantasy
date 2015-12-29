//
//  MoreViewController.m
//  product
//
//  Created by 谭永钊 on 15/8/1.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "MoreViewController.h"
#import "CalendarViewController.h"
#import "SettingCell.h"
#import "DailyWordCell.h"
#import "RelaxCell.h"
#import "UpDateViewController.h"
#import "ActivityViewController.h"
#import "SettingViewController.h"
#import "GoldCoinListViewController.h"
#import "MyControl.h"
@interface MoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, assign) BOOL hiddenTabbar;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatTableView];
    [self setUpNavgationBar];



}
- (void)setUpNavgationBar{
    
    self.navigationItem.title = @"More";
    self.view.backgroundColor = [UIColor whiteColor];
    //修改导航栏字体 大小 和 颜色
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0],NSFontAttributeName,nil];
    
    //修改参数
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
//    [item setTintColor:[UIColor whiteColor]];

    //    设置navigationController的背景图片
    self.navigationController.navigationBar.translucent = YES;
    UIImage * image = [UIImage imageNamed:@"navbackImage.jpg"];
    //    UIImage * imageNew = [image scaleToSize:CGSizeMake(WIDTH, 64)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:23.0], NSForegroundColorAttributeName:[UIColor colorWithRed:0.7871 green:0.9665 blue:0.9559 alpha:1.0]}];
    
    UIButton * button = [MyControl createButtonWithBackgroundColor:[UIColor lightGrayColor] target:self method:@selector(setting) normalImage:nil andLightImage:nil];
    button = [MyControl ButtonSetCornerRadiusWithButton:button andCornerRadius:5 andBorderWidth:0.5 andBorderColor:[UIColor grayColor]];
    button.frame = CGRectMake(0, 0, 60, 30);
    [button setTitle:@"设置" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];

}
- (void)creatTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID1 = @"cellID1";
    if (indexPath.row == 0) {
        SettingCell * cell = [tableView dequeueReusableCellWithIdentifier:ID1];
        if (!cell) {
            cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID1];
        }
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 1) {
        static NSString *ID2 = @"dailyWordCell";
        DailyWordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        if (!cell) {
            cell = [[DailyWordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];
        }
        return cell;
    } else if(indexPath.row == 2){
        
        static NSString * ID3 = @"relaxCell";
        RelaxCell * cell = [tableView dequeueReusableCellWithIdentifier:ID3];
        if (!cell) {
            cell = [[RelaxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID3];
        }
        return cell;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 170;
    }else if (indexPath.row == 1) {
        return 200;
    }else{
        
        return 300;
    }
}

- (void)lookCalendar{
    
//    NSLog(@"日历");
    CalendarViewController * calendarVC = [[CalendarViewController alloc]init];
    [self.navigationController pushViewController:calendarVC animated:YES];
}
- (void)upDate{
    
//    NSLog(@"更新");
    UpDateViewController * upDateVC = [[UpDateViewController alloc]init];
    [self.navigationController pushViewController:upDateVC animated:YES];
}
// 查看日历
- (void)dateCalculate{
    
    ActivityViewController * activityVC = [[ActivityViewController alloc]init];
    [self.navigationController pushViewController:activityVC animated:YES];
}
// 进入设置界面
- (void)setting{
    
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
// 进入金币排行榜界面
- (void)goldCoinList{

    GoldCoinListViewController * goldCoinListVC = [[GoldCoinListViewController alloc]init];
    [self.navigationController pushViewController:goldCoinListVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 显示tabbar
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
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

