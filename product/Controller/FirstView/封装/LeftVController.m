//
//  LeftVController.m
//  product
//
//  Created by qianfeng on 15/8/2.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "LeftVController.h"
#import "LeftVController.h"
#import "MainView.h"
#import "ZheXianView.h"
#import "ZheXianCell.h"
@interface LeftVController ()
{
    BOOL Open;
    BOOL temp;
    NSInteger temp_Height;
}
@property (nonatomic, strong) UIButton * button;

@property (nonatomic, strong) UISegmentedControl * segment;

@property (nonatomic, strong) MainView * mainView;

@end

@implementation LeftVController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    UILabel * dayLabel = [WHController labelWithFrame:CGRectNull andFont:40 andtext:@"Today"];
    dayLabel.textColor = [UIColor whiteColor];
    dayLabel.backgroundColor = [UIColor clearColor];
    dayLabel.font = [UIFont boldSystemFontOfSize:40];
    [self.view addSubview:dayLabel];
    dayLabel.frame = CGRectMake(10, 10, 200, 100);
    
    Open = YES;
    
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button addTarget:self action:@selector(buttonCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    self.button.backgroundColor = [UIColor clearColor];
    self.button.frame = CGRectMake(150, 50, 30, 30);
    
    NSArray * items = @[@"昨天",@"本周",@"本月"];
    _segment = [[UISegmentedControl alloc] initWithItems:items];
    _segment.backgroundColor = [UIColor clearColor];
    _segment.tintColor = [UIColor colorWithRed:0.974 green:0.976 blue:0.716 alpha:1.000];
    [self.view addSubview:_segment];
    _segment.frame = CGRectMake(10, 110, 200, 30);
    _segment.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    
    self.mainView = [[MainView alloc]init];
    [self.view addSubview:self.mainView];
    self.mainView.backgroundColor = [UIColor clearColor];
    self.mainView.frame = CGRectMake(10, 100, 200, 300);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  segmented 按钮点击
- (void)buttonCLick {
    
    if (Open) {
        [self viewWillAppear:Open];
        Open = NO;
    }
    else {
        [self viewWillAppear:Open];
        Open = YES;
    }
}

//  刷新界面    改变值 都在这里
-(void)viewWillAppear:(BOOL)animated{
    if (animated) {
        NSLog(@"----- YES   ");
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        //    设置动画时间
        [UIView setAnimationDuration:0.8];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_segment cache:YES];
        [self.button setBackgroundImage:[UIImage imageNamed:@"arrow_spread.png"] forState:UIControlStateNormal];
        _segment.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.mainView.frame = CGRectMake(10, 150, 200, 300);

        // 执行动画
        [UIView commitAnimations];
    }
    else {
        NSLog(@"----- NO    ");
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        //    设置动画时间
        [UIView setAnimationDuration:0.8];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_segment cache:YES];
        
        _segment.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
        self.mainView.frame = CGRectMake(10, 100, 200, 300);
        
        [self.button setBackgroundImage:[UIImage imageNamed:@"arrow_fold.png"] forState:UIControlStateNormal];
        // 执行动画
        [UIView commitAnimations];
    }
}


@end
