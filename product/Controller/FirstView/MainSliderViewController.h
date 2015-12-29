//
//  MainSliderViewController.h
//  product
//
//  Created by qianfeng on 15/8/2.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainTabBarController;

@interface MainSliderViewController : UIViewController{
    UIViewController * leftControl;
    MainTabBarController * mainTab;
    CGFloat scalef;
}

//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (assign,nonatomic) CGFloat speedf;

//是否允许点击视图恢复视图位置。默认为yes
@property (strong) UITapGestureRecognizer *sideslipTapGes;

//初始化
- (instancetype)initWithLeftView:(UIViewController *)leftView
                   andMainTabBar:(MainTabBarController *)mainTab;

//恢复位置
-(void)showMainView;

//显示左视图
-(void)showLeftView;


@end
