//
//  MainTabBarController.m
//  product
//
//  Created by JD -高 on 15/7/19.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "MainTabBarController.h"
#import "FirstVController.h"
#import "SecVController.h"
#import "ActivityViewController.h"
#import "MoreViewController.h"
#import "UIImage+Scale.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tabBar 背景颜色
//    [[UITabBar appearance] setBarTintColor:[UIColor colorWithWhite:0.873 alpha:1.000]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabback.jpg"]];
    //设置UITabBarItem 字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.977 green:1.000 blue:0.984 alpha:1.000], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    //选中状态下 文字的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.865 green:1.000 blue:0.404 alpha:1.000], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    //主界面  -->创建视图控制器
    FirstVController * firstVC = [[FirstVController alloc]init];
    //创建导航控制器 添加跟视图控制器
    UINavigationController * navFirstVC = [[UINavigationController alloc]initWithRootViewController:firstVC];

    
    //Sec界面
    SecVController * secVC = [[SecVController alloc]init];
    UINavigationController * navSecVC = [[UINavigationController alloc]initWithRootViewController:secVC];
    
    //Third界面
    ActivityViewController * activeVC = [[ActivityViewController alloc]init];
    //    activeVC.view.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.300];
    UINavigationController * navThirdVC = [[UINavigationController alloc]initWithRootViewController:activeVC];
    
    //Fifth
    MoreViewController * fifthVC = [[MoreViewController alloc]init];
    UINavigationController * navFifthVC = [[UINavigationController alloc]initWithRootViewController:fifthVC];
    
    //viewControllers数组~~自带的
    self.viewControllers = @[navFirstVC,navSecVC,navThirdVC,navFifthVC];
    
    [self createTabBar];
}

- (void)createTabBar{
    
    [self.tabBar setTintColor:[UIColor blackColor]];
    NSArray * arrTitle = @[@"首页",@"记事",@"日期计算",@"我的"];
    
    NSArray * selectIconImageName = @[@"Home sec",@"note.png",@"iconDate.png",@"mine.png"];
    NSArray * unselectIconImageName = @[@"Home.png",@"un_note.png",@"un_iconDate.png",@"un_mine.png"];
    
    for (int i = 0; i < arrTitle.count; i++) {
        
        UITabBarItem * item = self.tabBar.items[i];
        
        //图像大小处理
        UIImage * un_imageNew = [[[UIImage imageNamed:unselectIconImageName[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] scaleToSize:CGSizeMake(47, 47)];
        UIImage * imageNew = [[[UIImage imageNamed:selectIconImageName[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] scaleToSize:CGSizeMake(47, 47)];
        
        item = [item initWithTitle:arrTitle[i] image:[un_imageNew imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[imageNew imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
    }
    
}


@end
