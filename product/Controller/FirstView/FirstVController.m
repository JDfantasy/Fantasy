//
//  FirstVController.m
//  product
//
//  Created by JD -高 on 15/7/19.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "FirstVController.h"
#import "FirstCell.h"
#import "WhDatePicker.h"
#import "dateView.h"
#import "SecCell.h"
#import "GoldView.h"
#import "FirstFMDB.h"
#import "DataModel.h"
#import "ViewRight.h"
#import "VpathView.h"
#import "LeftPathView.h"
#import "RightPathView.h"
#import "UIImage+Scale.h"
#import "WeatherView.h"
@interface FirstVController () <UIAlertViewDelegate>

@property (nonatomic , copy) NSMutableArray * dataArr;
@property (nonatomic , copy) FirstFMDB * myData;
@property (nonatomic , copy) DataModel * dataModel;
@property (nonatomic , retain) GoldView * goldView;
@property (nonatomic , assign) NSInteger num;
@property (nonatomic , retain) ViewRight * viewRight;
@property (nonatomic , retain) NSTimer * timer;
@property (nonatomic , assign) NSInteger  time;
@property (nonatomic , retain) WeatherView * viewSmall;
@property (nonatomic , retain) UIView * textView;
@end

@implementation FirstVController

//  View即将消失...
- (void)viewWillDisappear:(BOOL)animated{
    //  隐藏属性 写在跳转之前
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"iTimer";
    
    _num = 0;
#pragma mark -- 创建数据库  data.db文件名
//    创建数据
    NSString * path = [NSString stringWithFormat:@"%@/Documents/dataFirst.db",NSHomeDirectory()];
    _myData = [[FirstFMDB alloc]initWithPath:path];
//    执行
    _dataArr = [[NSMutableArray alloc]init];
    FMResultSet * result = [_myData executeQuery:@"select * from isClicked"];
    while ([result next]) {
        NSString * num = [result stringForColumn:@"num"];
        NSString * clicked = [result stringForColumn:@"isClicked"];
        DataModel * model = [[DataModel alloc]init];
        model.num = num;
        model.isClicked = clicked;
        [_dataArr addObject:model];
    }
    NSLog(@"=%ld",_dataArr.count);
    NSLog(@"%@/Documents",NSHomeDirectory());

//    设置navigationController的背景图片
    self.navigationController.navigationBar.translucent = NO;
    UIImage * image = [UIImage imageNamed:@"navbackImage.jpg"];
//    UIImage * imageNew = [image scaleToSize:CGSizeMake(WIDTH, 64)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //修改导航栏字体 大小 和 颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:23.0], NSForegroundColorAttributeName:[UIColor colorWithRed:0.7871 green:0.9665 blue:0.9559 alpha:1.0]}];
//    添加左右2个Butto
    UIButton * button = [WHController buttonWithFrame:CGRectMake(0, 0, 45, 30) andTarget:self andMethod:@selector(mySelf:) andImageName:@"button 2.png" andTitle:@"个人"];
    [button setTitleColor:[UIColor colorWithRed:0.957 green:0.953 blue:0.939 alpha:1.000] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.view.backgroundColor = [UIColor colorWithRed:0.7541 green:0.7541 blue:0.7541 alpha:1.0];
    
    _goldView = [[GoldView alloc]init];
    [self.view addSubview:_goldView];
    UIImage * imageGold = [UIImage imageNamed:@"时针副本 6.png"];
    UIImage * imageNew = [imageGold scaleToSize:CGSizeMake(800 * (WIDTH / 320.0), 800 * (WIDTH / 320.0))];

    _goldView.backgroundColor = [UIColor colorWithPatternImage:imageNew];
    _goldView.center = CGPointMake(WIDTH/2, HEIGHT/2 + 220);
    _goldView.bounds = CGRectMake(0, 0, 800 * (WIDTH / 320.0), 800 * (WIDTH / 320.0));
    
    
    [self createButton];
    
//    for (int i= 0; i < 10; i++) {
//        if (i==4 || i==7) {
//            continue;
//        }else{
//            UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"金属板(1).png"]];
//            [self.view addSubview:imageView];
//            
//            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                
//                make.left.equalTo(self.view.left).offset(30 + i * 30);
//                make.right.equalTo(self.view.left).offset(58 + i * 30);
//                make.top.equalTo(self.view.top).offset(10);
//                make.height.equalTo(55);
//                
//            }];
//        }
//    }
    
    UIImageView * imageDate = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"日历背景.png"]];
    [self.view addSubview:imageDate];
    [imageDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(30);
        make.right.equalTo(self.view.right).offset(-30);
        make.top.equalTo(self.view.top).offset(10);
        make.height.equalTo(60);
    }];
    
//    当前时间
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY  MM  dd";
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    NSString * strTime = [formatter stringFromDate:date];
    
    UILabel * label = [WHController labelWithFrame:CGRectNull andFont:50.0 andtext:strTime];
    label.font = [UIFont boldSystemFontOfSize:50];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.3706 green:0.3706 blue:0.3706 alpha:1.0];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(30);
        make.right.equalTo(self.view.right).offset(-30);
        make.top.equalTo(self.view.top).offset(10);
        make.height.equalTo(60);
    }];
#pragma mark --分针圆
//    小圆
    _viewSmall = [[WeatherView alloc]initWithFrame:CGRectNull];
    [self.view addSubview:_viewSmall];
//    view.backgroundColor = [UIColor cyanColor];
    _viewSmall.bounds = CGRectMake(0, 0, 600 * (WIDTH / 320), 600 * (WIDTH / 320));
    _viewSmall.center = CGPointMake(_goldView.center.x,_goldView.center.y);
    _viewSmall.layer.borderWidth = 2;
    _viewSmall.layer.borderColor = [UIColor colorWithRed:0.961 green:0.964 blue:1.000 alpha:1.000].CGColor;
    _viewSmall.layer.masksToBounds = YES;
    
    UIImageView * redImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red.png"]];
    [self.view addSubview:redImageView];
    [redImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(WIDTH/2 - 21.5);
        make.right.equalTo(self.view.left).offset(WIDTH/2 + 21.5);
        make.top.equalTo(_viewSmall.top).offset(1);
        make.height.equalTo(25);
    }];
    
//    背景色
    UIImage * imageFen = [UIImage imageNamed:@"分针副本.png"];
    UIImage * FenImage = [imageFen scaleToSize:CGSizeMake(600 * (WIDTH / 320), 600 * (WIDTH / 320))];
    _viewSmall.backgroundColor = [UIColor colorWithPatternImage:FenImage];
    _viewSmall.layer.cornerRadius = 300 * (WIDTH/320);
    
    UIImage * imageWeather = [UIImage imageNamed:@"天气盘.png"];
    UIImage * newImageWeather = [imageWeather scaleToSize:CGSizeMake(300, 300)];
    UIImageView * imageViewWeather = [[UIImageView alloc]init];
    imageViewWeather.backgroundColor = [UIColor clearColor];
    imageViewWeather.image = newImageWeather;
    [self.view addSubview:imageViewWeather];
    imageViewWeather.frame = CGRectMake(0, 0, 350 * (WIDTH / 320), 350 * (WIDTH / 320));
    imageViewWeather.center = CGPointMake(_goldView.center.x,_goldView.center.y);
    
    
#pragma mark -- 定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    [_timer fire];
    //取消定时器
//    [_timer invalidate];
//    _timer = nil;
    //关闭定时器
//    [_timer setFireDate:[NSDate distantFuture]];
    //开启定时器
//    [_timer setFireDate:[NSDate distantPast]];
    
//    遮挡的View
//    LeftPathView * leftView = [[LeftPathView alloc]init];
//    leftView.backgroundColor = [UIColor clearColor];
//    //     _goldView.center = CGPointMake(WIDTH/2, HEIGHT/2 + 220);
//    leftView.frame = CGRectMake(0, 0, 90, 800 * (WIDTH / 320.0)-33);
//    leftView.center = CGPointMake(WIDTH/2 - 45, HEIGHT/2 +220);
//    leftView.transform = CGAffineTransformMakeRotation(-M_PI / 9.9f);
//    leftView.clipsToBounds =YES;
//    [self.view addSubview:leftView];
//    
//    RightPathView * rightView = [[RightPathView alloc]init];
//    rightView.backgroundColor = [UIColor clearColor];
//    //     _goldView.center = CGPointMake(WIDTH/2, HEIGHT/2 + 220);
//    rightView.frame = CGRectMake(0, 0, 90, 800 * (WIDTH / 320.0)-33);
//    rightView.center = CGPointMake(WIDTH/2 + 45, HEIGHT/2 +220);
//    rightView.transform = CGAffineTransformMakeRotation(M_PI / 9.9f);
//    rightView.clipsToBounds =YES;
//    [self.view addSubview:rightView];
    
    
//    V线
    VpathView * pathView = [[VpathView alloc]init];
    pathView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pathView];
    pathView.frame = CGRectMake(0, 0, 5, 800 * (WIDTH / 320.0));
    pathView.center = _goldView.center;
    pathView.transform = CGAffineTransformMakeRotation (M_PI / 12.0f);
//    V线
    VpathView * pathView2 = [[VpathView alloc]init];
    pathView2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pathView2];
    pathView2.frame = CGRectMake(0, 0, 5, 800 * (WIDTH / 320.0));
    pathView2.center = _goldView.center;
    pathView2.transform = CGAffineTransformMakeRotation (-M_PI / 12.0f);
    
    
#pragma mark -- 天气 View
    UIView * viewWeather = [[UIView alloc]init];
    viewWeather.frame = CGRectMake(0, 0, 140 * (WIDTH / 320), 140 * (WIDTH / 320));
    viewWeather.center = CGPointMake(_goldView.center.x,_goldView.center.y);
    viewWeather.backgroundColor = [UIColor colorWithRed: 0.9853 green: 0.971 blue: 0.8 alpha: 1.0];
    viewWeather.layer.masksToBounds = YES;
    viewWeather.layer.cornerRadius = 70 * (WIDTH / 320);
    [self.view addSubview:viewWeather];
    
    UILabel * labelWeather = [WHController labelWithFrame:CGRectNull andFont:35.0 andtext:@"29°C"];
    labelWeather.textAlignment = NSTextAlignmentCenter;
    labelWeather.font = [UIFont boldSystemFontOfSize:36];
    labelWeather.textColor = [UIColor colorWithRed: 0.8755 green: 0.5777 blue: 0.9987 alpha: 1.0];
    [viewWeather addSubview:labelWeather];
    [labelWeather mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWeather.left).offset(20);
        make.right.equalTo(viewWeather.right).offset(-20);
        make.top.equalTo(viewWeather.top).offset(35);
        make.height.equalTo(35);
    }];
    
//    添加手势  滑动手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [_goldView addGestureRecognizer:pan];
//    [pathView addGestureRecognizer:pan];
    
    
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
////    添加滑动方向 向右滑动
//    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [_goldView addGestureRecognizer:swipeRight];
//

    
    UIImage * imageH = [UIImage imageNamed:@"无边玻璃罩.png"];
    UIImage * NewImageH = [imageH scaleToSize:CGSizeMake(700 * (WIDTH / 320), 700 * (WIDTH / 320))];
    UIImageView * imageViewH = [[UIImageView alloc]init];
//    imageViewH.backgroundColor = [UIColor colorWithWhite:0.681 alpha:0.500];
    imageViewH.image = NewImageH;
    [self.view addSubview:imageViewH];
    imageViewH.frame = CGRectMake(0, 0, 775 * (WIDTH / 320), 775 * (WIDTH / 320));
    imageViewH.center = CGPointMake(_goldView.center.x,_goldView.center.y);
//    三角 指针
    UIImage * imageA = [UIImage imageNamed:@"gray.png"];
    UIImage * NewImageA = [imageA scaleToSize:CGSizeMake(300, 300)];
    UIImageView * imageViewA = [[UIImageView alloc]init];
    imageViewA.image = NewImageA;
    [self.view addSubview:imageViewA];
    [imageViewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewWeather.top).offset(-72);
        make.height.equalTo(90);
        make.left.equalTo(viewWeather.left).offset(73.5);
        make.width.equalTo(15);
    }];
//    红线
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imageViewA.top).offset(5);
        make.height.equalTo(100);
        make.left.equalTo(imageViewA.left).offset(7.5);
        make.width.equalTo(0.5);
    }];
    
#pragma marl -- 侧滑的View
    _viewRight = [[ViewRight alloc]initWithFrame:CGRectMake(WIDTH, 40, WIDTH - 40, HEIGHT - 230)];
    //    如果只是需要父视图 透明度 则不能直接设置透明度~~而是设置颜色的透明度
    _viewRight.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    //    _viewRight.alpha = 0.4;
    [self.view addSubview:_viewRight];
    
    //    添加手势  滑动手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft:)];
    //    添加滑动方向 向左滑动
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    //    添加手势  单击
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    //    [_goldView addGestureRecognizer:tap];
    //    长按手势
    UILongPressGestureRecognizer * press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
    //    添加长按手势
    [_goldView addGestureRecognizer:press];
    
    _textView = [[UIView alloc] init];
    _textView.backgroundColor = [UIColor colorWithRed:0.770 green:1.000 blue:0.913 alpha:0.600];
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 30;
    _textView.frame = CGRectMake(0, 0, 150, 120);
    _textView.center = CGPointMake(WIDTH/2, HEIGHT/2 - 70);
    [self.view addSubview:_textView];
    _textView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    
    UILabel * labelText = [WHController labelWithFrame:CGRectNull andFont:16.0 andtext:@"请输入内容"];
    labelText.textAlignment = NSTextAlignmentCenter;
    [_textView addSubview:labelText];
    labelText.frame = CGRectMake(25, 5, 100, 30);
}

////  longPress
-(void)longPress {
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:1.0f];//动画时间
    _textView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitAnimations];
}
//  tap
- (void)tap:(UITapGestureRecognizer *)tap{

    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:1.0f];//动画时间
    _viewRight.center = CGPointMake(WIDTH + WIDTH/2, HEIGHT/2+230);
    _viewRight.transform=CGAffineTransformMakeScale(0.1f, 0.1f);//先让要显示的view最小直至消失
    _textView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView commitAnimations];
    
}

//  swipe方法
- (void)swipeLeft:(UISwipeGestureRecognizer *)swipeRight{
    _viewRight.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    //将要显示的view按照正常比例显示出来
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:1.0f];//动画时间
    _viewRight.center = CGPointMake(WIDTH/2, HEIGHT/2 - 30);
//    _goldView.transform=CGAffineTransformMakeScale(0.4f, 0.4f);
    //先让要显示的view最小直至消失
    [UIView commitAnimations];
}


//  手势的方法 pan主要用于移动视图
- (void)handlePan:(UIPanGestureRecognizer*) recognizer{
    
    //通过手势实例的 translationInView 方法可以获取到变化前后两个位置的x和y的差
    CGPoint deltaPoint = [recognizer translationInView:self.view];
    //传入x 和 y前后差, 通过图形变化实现平移
//    [_goldView setTransform:CGAffineTransformMakeTranslation(deltaPoint.x, deltaPoint.y)];
    
//    判断左右滑动
    if (deltaPoint.x > 0) {
        [self startView];
        _num = _num + 2;
    }else{
        [self startView];
        _num = _num - 2;
    }
}

- (void)startView{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
//    点击也会触发该方法 无限循环
//    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    _goldView.transform = CGAffineTransformMakeRotation(_num * (M_PI / 180.0f));
    [UIView commitAnimations];
}
//- (void)endAnimation{
//    _num = _num +1;
//    [self startView];
//}

- (void)createButton{
    
    int R = 937.5 / 2;
    int d = 937.5/2 - 60;
    
    NSArray * arrZuoBiao =
  @[NSStringFromCGPoint(CGPointMake(R, 60)),
    NSStringFromCGPoint(CGPointMake(R+0.2588*d, R-0.966 *d)),
    
    NSStringFromCGPoint(CGPointMake(R+d/2, R-0.866*d)),
    NSStringFromCGPoint(CGPointMake(R+0.707*d, R -0.707*d)),
    
    NSStringFromCGPoint(CGPointMake(R+0.866*d, R - d/2)),
    NSStringFromCGPoint(CGPointMake(R+0.966*d, R - 0.2588*d)),
    
    NSStringFromCGPoint(CGPointMake(2*R-60, R)),
    NSStringFromCGPoint(CGPointMake(R+0.966*d, R+0.2588*d)),
    
    NSStringFromCGPoint(CGPointMake(R+0.866*d, R+d/2)),
    NSStringFromCGPoint(CGPointMake(R+0.707*d, R+0.707*d)),
    
    NSStringFromCGPoint(CGPointMake(R+d/2, R+0.866*d)),
    NSStringFromCGPoint(CGPointMake(R+0.2588*d, R+0.966*d)),
    
    NSStringFromCGPoint(CGPointMake(R, 2*R-60)),
    NSStringFromCGPoint(CGPointMake(R-0.2588*d, R+0.966*d)),
    
    NSStringFromCGPoint(CGPointMake(R-d/2, R+0.866*d)),
    NSStringFromCGPoint(CGPointMake(R-0.707*d, R+0.707*d)),
    
    NSStringFromCGPoint(CGPointMake(R-0.866*d, R+d/2)),
    NSStringFromCGPoint(CGPointMake(R-0.966*d, R+0.2588*d)),
    
    NSStringFromCGPoint(CGPointMake(60, R)),
    NSStringFromCGPoint(CGPointMake(R-0.966*d, R-0.2588*d)),
    
    NSStringFromCGPoint(CGPointMake(R-0.866*d, R-d/2)),
    NSStringFromCGPoint(CGPointMake(R-0.707*d, R-0.707*d)),
    
    NSStringFromCGPoint(CGPointMake(R-d/2, R-0.866*d)),
    NSStringFromCGPoint(CGPointMake(R-0.2588*d, R-0.966*d)),];
    
    NSArray * arrImage = @[@"24.png",@"1.png",@"2.png",@"3.png",@"4.png",@"5.png",@"6.png",@"7.png",@"8.png",@"9.png",@"10.png",@"11.png",@"12.png",@"13.png",@"14.png",@"15.png",@"16.png",@"17.png",@"18.png",@"19.png",@"20.png",@"21.png",@"22.png",@"23.png"];
//    NSArray * arrImage = @[@"24 副本.png",@"1 副本.png",@"2 副本.png",@"3 副本.png",@"4 副本.png",@"5 副本.png",@"6 副本.png",@"7 副本.png",@"8 副本.png",@"9 副本.png",@"10 副本.png",@"11 副本.png",@"12 副本.png",@"13 副本.png",@"14 副本.png",@"15 副本.png",@"16 副本.png",@"17 副本.png",@"18 副本.png",@"19 副本.png",@"20 副本.png",@"21 副本.png",@"22 副本.png",@"23 副本.png"];
    for (int i = 0; i < 24; i++) {
        UIButton * button = [WHController buttonWithFrame:CGRectNull andTarget:self andMethod:@selector(click:) andImageName:[NSString stringWithFormat:@"%@",arrImage[i]] andTitle:nil];

//        button.transform = CGAffineTransformMakeRotation(i *(M_PI/12));
        button.tag = 1000+i;
        button.frame =CGRectMake(0, 0, 60, 60);
        button.center = CGPointFromString(arrZuoBiao[i]);
        [_goldView addSubview:button];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 30;
        

    }
}

#pragma mark -- button 点击事件
- (void)mySelf:(UIButton *)button{
    //将要显示的view按照正常比例显示出来
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:1.0f];//动画时间
//    mainTab.view.center = CGPointMake(WIDTH + 50, HEIGHT/2);
//    mainTab.view.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
    UIView * view = [[[[[[[[[self.view superview] superview] superview] superview] superview] superview] superview] subviews] objectAtIndex:1];
//    NSLog(@"%@",[[[[[[[[[self.view superview] superview] superview] superview] superview] superview] superview] subviews] objectAtIndex:1]);
    if (view.center.x > WIDTH/2) {
        view.center = CGPointMake(WIDTH/2, HEIGHT/2);
        view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }else{
        view.center = CGPointMake(WIDTH + 50, HEIGHT/2);
        view.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
    }
    
    
    
    //    _goldView.transform=CGAffineTransformMakeScale(0.4f, 0.4f);
    //先让要显示的view最小直至消失
    [UIView commitAnimations];
}

- (void)click:(UIButton *)button{
    NSLog(@"!");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    //    设置动画时间
    [UIView setAnimationDuration:0.8];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:button cache:YES];
    
    NSInteger tag = button.tag;
//    
    NSArray * arrImage = @[@"24副本.png",@"1副本.png",@"2副本.png",@"3副本.png",@"4副本.png",@"5副本.png",@"6副本.png",@"7副本.png",@"8副本.png",@"9副本.png",@"10副本.png",@"11副本.png",@"12副本.png",@"13副本.png",@"14副本.png",@"15副本.png",@"16副本.png",@"17副本.png",@"18副本.png",@"19副本.png",@"20副本.png",@"21副本.png",@"22副本.png",@"23副本.png"];
    
    button.alpha = 0.6;
    // 执行动画
    [UIView commitAnimations];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",arrImage[tag-1000]]] forState:UIControlStateNormal];

}

- (void)scrollTimer{
//    M_PI /15/3600
    
    //    当前时间
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"HH mm ss";
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    NSString * strTime = [formatter stringFromDate:date];
    NSLog(@"%@",strTime);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    //    设置动画时间
    [UIView setAnimationDuration:1.5];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_goldView cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_viewSmall cache:YES];
    _goldView.transform = CGAffineTransformMakeRotation(_time*(-M_PI/180));
    _viewSmall.transform = CGAffineTransformMakeRotation(_time*(M_PI/60));
    
    // 执行动画
    [UIView commitAnimations];
    _time++;
}

@end
