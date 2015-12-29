//
//  SettingViewController.m
//  app_mechanics
//
//  Created by qianfeng on 15/7/24.
//  Copyright (c) 2015年 vincent. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "CountManagerViewController.h"
#import "AppDelegate.h"
//单例
#import "BrightnessView.h"
#import "UpDateViewController.h"
#import "UMFeedback.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,assign) NSInteger section;

@property   (nonatomic, strong) UITableView * NewTableView;

@property   (nonatomic, copy) NSArray * arr;

@property   (nonatomic, copy) NSArray * arr1;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _arr = [[NSArray alloc] init];
    NSArray * arr1 = [NSArray array];
    NSArray * arr2 = [NSArray array];
    NSArray * arr3 = [NSArray array];
    NSArray * arr4 = [NSArray array];
    
    arr1 = @[@"账号管理"];
//    arr2 = @[@"推送服务"];
    arr2 = @[@"调节亮度"];
    arr3 = @[@"清理缓存",@"检查更新",@"更多应用"];
    arr4 = @[@"新手指南",@"用户反馈",@"关于我们"];
    _arr = @[arr1,arr2,arr3,arr4];
    
    _arr1 = [[NSArray alloc] init];
    NSArray * arr_1 = [NSArray array];
    NSArray * arr_2 = [NSArray array];
    NSArray * arr_3 = [NSArray array];
    NSArray * arr_4 = [NSArray array];
    
    arr_1 = @[@"shezhi00.png"];

    arr_2 = @[@"shezhi20.png"];
    arr_3 = @[@"shezhiqingli.png",@"shezhigengxin.png",@"shezhigengduo.png"];
    arr_4 = @[@"shezhi00.png",@"shezhi00.png",@"shezhi00.png"];
    _arr1 = @[arr_1,arr_2,arr_3,arr_4];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"img_top.png"] forBarMetrics:UIBarMetricsDefault];
    
    _NewTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _NewTableView.dataSource = self;
    _NewTableView.delegate = self;
    _NewTableView.backgroundColor = [UIColor lightGrayColor];
    _NewTableView.allowsMultipleSelectionDuringEditing = YES;
 
    [self.view addSubview:_NewTableView];
    // 隐藏tabbar
//    self.tabBarController.tabBar.hidden = YES;
//    self.navigationItem.title = @"设置";

    //调节亮度
    AppDelegate *Adg = [[UIApplication sharedApplication] delegate];
    BrightnessView *halfLight = [BrightnessView sharedSingleClass];
    halfLight.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    halfLight.userInteractionEnabled = NO;
    [Adg.window addSubview:halfLight];
    
}

#pragma UITableViewDelegate
//  注意设置高度，完全不显示
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 10;
            break;
        default:
            return 20;
            break;
    }
}



#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


- (SettingTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellID = @"cellID";
    //  尝试去对象池中取 id 为 cellID 的对象
    SettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    //  如果取不到对象
    
    NSArray * arr_temp = _arr[indexPath.section];
    NSString * str_temp = arr_temp[indexPath.row];
//    NSLog(@"%@",str_temp);
    
    NSArray * arr_image = _arr1[indexPath.section];
    NSString * imageName = arr_image[indexPath.row];
//    NSLog(@"%@",imageName);
    

    if (cell == nil) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault string:str_temp reuseIdentifier:cellID];
    }
    UIView * tempView = [[UIView alloc] init];
    tempView.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = tempView;
    
    
    if ([str_temp isEqualToString:@"账号管理"]) {
        UITapGestureRecognizer * hand = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GotoNext)];
        [cell addGestureRecognizer:hand];
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            _section = indexPath.section;
        }
    }

    [cell setValueForCellWithstring:str_temp image:imageName current_image:@"weidu.png"reuseIdentifier:cellID];
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 2 && indexPath.row == 0) {
        // 清除缓存
        [self clear];
    }
    if (indexPath.section == 2 && indexPath.row == 1){
    
        [self upDate];
    }
    if (indexPath.section == 3 && indexPath.row == 1){
        
        //反馈界面，使用友盟的反馈插件
        [UMFeedback showFeedback:self withAppkey:@"5021ee8c5270155302000003"];
    }
}
// 进入更新页面
- (void)upDate{
    
//    NSLog(@"更新");
    UpDateViewController * upDateVC = [[UpDateViewController alloc]init];
    [self.navigationController pushViewController:upDateVC animated:YES];
}
// 清除缓存
- (void)clear{

    // 清除缓存
    UIAlertView * alert =[ [UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除缓存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    NSString * documentPath =[NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
//    NSLog(@"%@",documentPath);
    BOOL isDataExist=[[NSFileManager defaultManager]fileExistsAtPath:documentPath];
//    NSLog(@"~~~~~~~%d",isDataExist);
    if (isDataExist)
    {
        long long content=[[[NSFileManager defaultManager]attributesOfItemAtPath:documentPath error:nil]fileSize];
        float size=content/1024.0;
        NSString * content2 = [NSString stringWithFormat:@"%.2fMB",size];
        alert.message = [@"是否删除缓存" stringByAppendingString:content2];
        [ [NSFileManager defaultManager]removeItemAtPath:documentPath error:nil];
        [alert show] ;
    }
    else
    {
        alert.message = @"暂无缓存";
        [alert show];
    }

}

-(void)GotoNext {

    CountManagerViewController * CMVC = [[CountManagerViewController alloc] init];
    [self.navigationController pushViewController:CMVC animated:YES];

}

-(void)AlertMove {
    
//    NSLog(@"%ld",_section);
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请先登陆" delegate:self cancelButtonTitle:@"稍后登陆" otherButtonTitles:@"登陆", @"注册",nil];
    [alertView setAlertViewStyle:UIAlertViewStyleDefault];

    [alertView show];

}

// 改变亮度
- (void)changeBrightness{
    
//    NSLog(@"=====");
    //明暗交替
    static  BOOL openNightMode = YES;
    if (openNightMode){
        //单例
        BrightnessView *halfLight = [BrightnessView sharedSingleClass];
        
        halfLight.backgroundColor = [UIColor blackColor];
        halfLight.alpha = 0.5f;
    }else{
        BrightnessView *halfLight = [BrightnessView sharedSingleClass];
        halfLight.backgroundColor = [UIColor clearColor];
    }
    openNightMode = !openNightMode;
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
