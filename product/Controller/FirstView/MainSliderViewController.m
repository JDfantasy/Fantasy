//
//  MainSliderViewController.m
//  product
//
//  Created by qianfeng on 15/8/2.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "MainSliderViewController.h"
#import "MainTabBarController.h"
@interface MainSliderViewController () <UIGestureRecognizerDelegate>

@end

@implementation MainSliderViewController


- (instancetype)initWithLeftView:(UIViewController *)leftView
                   andMainTabBar:(MainTabBarController *)mainView{

    
    if (self = [super init]) {
        _speedf = 0.5;
        
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]];
        leftControl = leftView;
        mainTab = mainView;
        

//        滑动手势
//        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
    //    添加滑动方向 向右滑动
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [mainTab.view addGestureRecognizer:swipeRight];
        
        //单击手势
        _sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [_sideslipTapGes setNumberOfTapsRequired:1];
        
        [mainTab.view addGestureRecognizer:_sideslipTapGes];
//        隐藏视图
        leftControl.view.hidden = NO;
        [self.view addSubview:leftControl.view];
        [self.view addSubview:mainTab.view];
        
        
        _sideslipTapGes.delegate = self;
    }
    
    return self;
}
#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    //将要显示的view按照正常比例显示出来
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:1.0f];//动画时间
    mainTab.view.center = CGPointMake(WIDTH/2, HEIGHT/2);
    mainTab.view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    //    _goldView.transform=CGAffineTransformMakeScale(0.4f, 0.4f);
    //先让要显示的view最小直至消失
    [UIView commitAnimations];
    
}

#pragma mark - 滑动手势

//滑动手势
- (void) swipeRight: (UISwipeGestureRecognizer *)rec{
    
    
    
    //将要显示的view按照正常比例显示出来
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:1.0f];//动画时间
    mainTab.view.center = CGPointMake(WIDTH + 50, HEIGHT/2);
    mainTab.view.transform = CGAffineTransformMakeScale(0.8f, 0.8f);

    //    _goldView.transform=CGAffineTransformMakeScale(0.4f, 0.4f);
    //先让要显示的view最小直至消失
    [UIView commitAnimations];
    
//    <UIView: 0x7ff911ffbd30; frame = (0 0; 375 667); autoresize = W+H; layer = <CALayer: 0x7ff911ffbc50>>

}
//    拦截事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITabBarButton"]) {
        return NO;
    }else if([NSStringFromClass([touch.view class]) isEqualToString:@"UINavigationBar"]) {
        return NO;
    }else if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    [UIView beginAnimations:nil context:nil];
    mainTab.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    mainTab.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

//显示左视图
-(void)showLeftView{
    [UIView beginAnimations:nil context:nil];
    mainTab.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
    mainTab.view.center = CGPointMake(340,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
