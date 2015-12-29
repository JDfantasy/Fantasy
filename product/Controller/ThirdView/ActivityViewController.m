//
//  ActivityViewController.m
//  Sunday
//
//  Created by qianfeng on 15/7/26.
//  Copyright (c) 2015年 yanchao. All rights reserved.
//

#import "ActivityViewController.h"
#import "MyControl.h"
@interface ActivityViewController ()<UITextFieldDelegate>
{
    UITextField * _field1;
    UITextField * _field2;
    NSDate * _date1;
    NSDate * _date_before;
    UILabel *_label1;
    UILabel *_label2;
    UILabel *_NumberLabel;
    UILabel * _startViewLabel2;
    UILabel * _endViewLabel2;
    UIView *_backView;
    UIAlertView * _alert1;
    UIView *_backView2;//pickerDate所在view
    UIAlertView * _alert2;
    UIButton *_alertbutton;//pickerDate回收按钮
    UIButton *_alertbutton2;//pickerDate回收按钮2
    UIDatePicker *_control;
}
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    设置navigationController的背景图片
    self.navigationController.navigationBar.translucent = NO;
    UIImage * image = [UIImage imageNamed:@"navbackImage.jpg"];
    //    UIImage * imageNew = [image scaleToSize:CGSizeMake(WIDTH, 64)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed: 0.7541 green: 0.7541 blue: 0.7541 alpha: 1.0];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"日期计算器";
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0],NSFontAttributeName,nil];
    
    
    
    //修改参数
    [self.navigationController.navigationBar setTitleTextAttributes:dict];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:23.0], NSForegroundColorAttributeName:[UIColor colorWithRed:0.7871 green:0.9665 blue:0.9559 alpha:1.0]}];
    
    //mainView
    UIView  *mainView = [MyControl createViewWithBackgroundColor:[UIColor whiteColor] andRornerRadius:8 andMasksToBounds:YES andBorderWidth:1 andBorderColor:[UIColor colorWithWhite:0.000 alpha:0.300]];
    [self.view addSubview:mainView];

    //contentView
    UIView *contentView = [MyControl createViewWithBackgroundColor:[UIColor whiteColor] andRornerRadius:8 andMasksToBounds:YES andBorderWidth:1 andBorderColor:[UIColor colorWithWhite:0.000 alpha:0.300]];
    [self.view addSubview:contentView];
    
    //startView  从。。。开始
    UIView * startView = [MyControl createViewWithBackgroundColor:[UIColor colorWithWhite:0.500 alpha:0.150] andRornerRadius:0 andMasksToBounds:YES andBorderWidth:1 andBorderColor:[UIColor colorWithWhite:0.000 alpha:0.150]];
    [contentView addSubview:startView];
    
    //startViewLabel1  从。。。开始 Label
    UILabel *startViewLabel1 = [MyControl createLabelWithText:@"从" andTextColor:[UIColor colorWithWhite:0.000 alpha:0.410] andTextAlignment:NSTextAlignmentLeft andbackgroundColor:nil andfont:[UIFont systemFontOfSize:14]];
    [startView addSubview:startViewLabel1];
    
#pragma mark --date1
   
    NSString *str = [MyControl DateIntoStrWithDate:[NSDate date]];
    
    _startViewLabel2 = [MyControl createLabelWithText:str andTextColor:[UIColor colorWithRed:0.145 green:0.400 blue:0.678 alpha:1.000] andTextAlignment:NSTextAlignmentLeft andbackgroundColor:nil andfont:[UIFont systemFontOfSize:12 weight:0.7]];
    [startView addSubview:_startViewLabel2];
    
    UILabel *startViewLabel3 = [MyControl createLabelWithText:@"开始" andTextColor:[UIColor colorWithWhite:0.000 alpha:0.410] andTextAlignment:NSTextAlignmentLeft andbackgroundColor:nil andfont:[UIFont systemFontOfSize:14]];
    [startView addSubview:startViewLabel3];
    
#pragma mark -- 倒三角 时间选择按钮1
    // 时间选择按钮
    UIButton *triangle = [UIButton buttonWithType:UIButtonTypeCustom];
//    triangle.backgroundColor = [UIColor redColor];
    [triangle setImage:[UIImage imageNamed:@"strangle"] forState:UIControlStateNormal];
    [triangle addTarget:self action:@selector(triangleClick) forControlEvents:UIControlEventTouchUpInside];
    [startView addSubview:triangle];
    //初始化alert所在view
    _backView = [MyControl createViewWithBackgroundColor:[UIColor whiteColor] andRornerRadius:0 andMasksToBounds:YES andBorderWidth:1 andBorderColor:[UIColor colorWithWhite:0.500 alpha:0.400]];
    [self.view addSubview:_backView];
    _backView.hidden = YES;
    
    _alert1 = [MyControl createAlertViewWithBackgroundColor:[UIColor colorWithWhite:0.500 alpha:0.150] andRornerRadius:7 andMasksToBounds:YES andBorderWidth:1 andBorderColor:[UIColor colorWithWhite:0.500 alpha:0.400]];
    [_backView addSubview:_alert1];
    
    //datePicker1
    UIDatePicker * datePicker = [MyControl createDatePickerWithTarget:self andAction:@selector(dateChange:)];
    //datePicker1 配置日期范围
    NSDate * minDate = [MyControl StrIntoDateWithStr:@"1900-01-01 "];
    NSDate *maxDate = [MyControl StrIntoDateWithStr:@"2100-01-01 "];
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
    [_alert1 addSubview:datePicker];
    
    //_alertbutton 回收按钮
    _alertbutton = [MyControl createButtonWithBackgroundColor:nil target:self method:@selector(alertButtonClick:)  normalImage:[UIImage imageNamed:@"button"] andLightImage:nil];
    
    _alertbutton = [MyControl ButtonSetCornerRadiusWithButton:_alertbutton andCornerRadius:5 andBorderWidth:1 andBorderColor:[UIColor colorWithWhite:0.500 alpha:0.500]];
    [self.view addSubview:_alertbutton];
    _alertbutton.hidden = YES;
    
 #pragma mark -- textfield1
    //field1 ...天之前
    _field1 = [[UITextField alloc]init];
    _field1.textAlignment = NSTextAlignmentRight;
    _field1.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:_field1];
    //右视图
    UIView *fieldRight = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    fieldRight.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.100];
    _field1.rightView = fieldRight;
    fieldRight.layer.masksToBounds = YES;
    _field1.rightViewMode = UITextFieldViewModeAlways;
    
    //竖直分界线
    UILabel *rightViewLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1, 30)];
    rightViewLabel1.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.110];
    [_field1.rightView addSubview:rightViewLabel1];
    
    UILabel *rightViewLabel2 = [MyControl createLabelWithText:@"天之前" andTextColor:[UIColor colorWithWhite:0.000 alpha:0.410] andTextAlignment:NSTextAlignmentCenter andbackgroundColor:nil andfont:[UIFont systemFontOfSize:12.0]];
    rightViewLabel2.frame = CGRectMake(0, 0, 60, 30);
    [_field1.rightView addSubview:rightViewLabel2];
    
    //键盘1
    _field1.delegate = self;
    _field1.keyboardType = UIKeyboardTypeNumberPad;
    
    //Label1  请输入数字开始计算
    _label1 = [MyControl createLabelWithText:@"请输入数字开始计算" andTextColor:[UIColor colorWithWhite:0.000 alpha:0.700] andTextAlignment:NSTextAlignmentCenter andbackgroundColor:nil andfont:[UIFont systemFontOfSize:14]];
    [contentView addSubview:_label1];
    
#pragma mark -- textfield2
    //field2
    _field2 = [[UITextField alloc]init];
    _field2.textAlignment = NSTextAlignmentRight;
    _field2.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:_field2];
    //右视图
    UIView *field2Right = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    field2Right.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.100];
    field2Right.layer.masksToBounds = YES;
    _field2.rightView = field2Right;
    _field2.rightViewMode = UITextFieldViewModeAlways;
    
    //竖直分界线
    UILabel *right2ViewLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1, 30)];
    right2ViewLabel1.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.110];
    [_field2.rightView addSubview:right2ViewLabel1];
    
    UILabel *right2ViewLabel2 = [MyControl createLabelWithText:@"天之后" andTextColor:[UIColor colorWithWhite:0.000 alpha:0.410] andTextAlignment:NSTextAlignmentCenter andbackgroundColor:nil andfont:[UIFont systemFontOfSize:12.0]];
    right2ViewLabel2.frame = CGRectMake(0, 0, 60, 30);
    
    [_field2.rightView addSubview:right2ViewLabel2];
    
    //键盘2
    _field2.delegate = self;
    _field2.keyboardType = UIKeyboardTypeNumberPad;
    
    //Label2  请输入数字开始计算
    _label2 = [MyControl createLabelWithText:@"请输入数字开始计算" andTextColor:[UIColor colorWithWhite:0.000 alpha:0.700] andTextAlignment:NSTextAlignmentCenter andbackgroundColor:nil andfont:[UIFont systemFontOfSize:14]];
    [contentView addSubview:_label2];
    
    //endView  距离 ... 还有
    UIView * endView = [MyControl createViewWithBackgroundColor:[UIColor colorWithWhite:0.500 alpha:0.150] andRornerRadius:0 andMasksToBounds:YES andBorderWidth:1 andBorderColor:[UIColor colorWithWhite:0.000 alpha:0.150]];
    [contentView addSubview:endView];
    
    //距离 ... 还有 Label
    UILabel *endViewLabel1 = [MyControl createLabelWithText:@"距离" andTextColor:[UIColor colorWithWhite:0.000 alpha:0.410] andTextAlignment:NSTextAlignmentLeft andbackgroundColor:nil andfont:[UIFont systemFontOfSize:14]];
    [endView addSubview:endViewLabel1];
    
#pragma mark --date2
    _endViewLabel2 = [MyControl createLabelWithText:str andTextColor:[UIColor colorWithRed:0.145 green:0.400 blue:0.678 alpha:1.000]andTextAlignment:NSTextAlignmentLeft andbackgroundColor:nil andfont:[UIFont systemFontOfSize:12 weight:0.7]];
    [endView addSubview:_endViewLabel2];
    
    UILabel *endViewLabel3 = [MyControl createLabelWithText:@"还有" andTextColor:[UIColor colorWithWhite:0.000 alpha:0.410] andTextAlignment:NSTextAlignmentLeft andbackgroundColor:nil andfont:[UIFont systemFontOfSize:14]];
    [endView addSubview:endViewLabel3];
#pragma mark -- 倒三角 时间选择按钮2
    // 时间选择按钮
    UIButton *triangle2 = [MyControl createButtonWithBackgroundColor:nil target:self method:@selector(triangleClick2) normalImage:[UIImage imageNamed:@"strangle"] andLightImage:nil];
    [endView addSubview:triangle2];
    
    //alert所在view
    _backView2 = [MyControl createViewWithBackgroundColor:[UIColor whiteColor] andRornerRadius:1 andMasksToBounds:YES andBorderWidth:1 andBorderColor:[UIColor colorWithWhite:0.500 alpha:0.400]];
    [self.view addSubview:_backView2];
    _backView2.hidden = YES;
    
    _alert2 = [MyControl createAlertViewWithBackgroundColor:[UIColor colorWithWhite:0.500 alpha:0.150] andRornerRadius:7 andMasksToBounds:YES andBorderWidth:1 andBorderColor:[UIColor colorWithWhite:0.500 alpha:0.400]];
    [_backView2 addSubview:_alert2];
    
    //datePicker2
    UIDatePicker * datePicker2 = [MyControl createDatePickerWithTarget:self andAction:@selector(dateChange2:)];
    [_alert2 addSubview:datePicker2];
    
    //_alertbutton2 回收按钮
    _alertbutton2 = [MyControl createButtonWithBackgroundColor:nil target:self method:@selector(alertButton2Click:) normalImage:[UIImage imageNamed:@"button"] andLightImage:nil];
    _alertbutton2 = [MyControl ButtonSetCornerRadiusWithButton:_alertbutton2 andCornerRadius:5 andBorderWidth:1 andBorderColor:[UIColor colorWithWhite:0.500 alpha:0.500]];
    [self.view addSubview:_alertbutton2];
    _alertbutton2.hidden = YES;
    
    //Number
    _NumberLabel = [MyControl createLabelWithText:@"0" andTextColor:[UIColor colorWithRed:0.145 green:0.400 blue:0.678 alpha:1.000] andTextAlignment:NSTextAlignmentRight andbackgroundColor:[UIColor whiteColor] andfont:[UIFont systemFontOfSize:22 weight:1]];
    [contentView addSubview:_NumberLabel];

    //DaysShow
    UILabel *DayLabel = [MyControl createLabelWithText:@"Days" andTextColor:[UIColor whiteColor] andTextAlignment:NSTextAlignmentCenter andbackgroundColor:[UIColor colorWithWhite:0.500 alpha:0.580] andfont:[UIFont systemFontOfSize:12 weight:1]];
    DayLabel.layer.cornerRadius = 4;
    DayLabel.layer.masksToBounds = YES;
    [contentView addSubview:DayLabel];
    
    //imageButton
    UIButton *imageButton = [MyControl createButtonWithBackgroundColor:nil target:self method:@selector(ImgButtonClick) normalImage:[UIImage imageNamed:@"DateButtonImage"] andLightImage:[UIImage imageNamed:@"DateButtonImagePress"]];
    [self.view addSubview:imageButton];

#pragma mark --约束
    //mainview
    UIView *sueperView = self.view;
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sueperView.left).offset(@8);
        make.right.equalTo(sueperView.right).offset(-8);
        make.top.equalTo(sueperView.top).offset(@8);
        make.bottom.equalTo(sueperView.bottom).offset(-57);
    }];
    //contentView
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.left).offset(@20);
        make.right.equalTo(mainView.right).offset(-20);
        make.top.equalTo(mainView.top).offset(@80);
        make.bottom.equalTo(mainView.bottom).offset(-120);
    }];
    
    //startView
    [startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(@-1);
        make.top.equalTo(contentView.top).offset(@-1);
        make.right.equalTo(contentView.right).offset(@1);
        make.height.equalTo(40);
    }];
    
    //startViewLabel
    int leftWid = (WIDTH - 210)/2;
    [startViewLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startView.left).offset(leftWid-10);
        make.top.equalTo(startView.top).offset(11);
        make.width.equalTo(16);
        make.bottom.equalTo(startView.bottom).offset(-9);
    }];
    [_startViewLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startViewLabel1.right).offset(10);
        make.top.equalTo(startView.top).offset(11);
        make.width.equalTo(110);
        make.bottom.equalTo(startView.bottom).offset(-9);
    }];
    [startViewLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_startViewLabel2.right).offset(10);
        make.top.equalTo(startView.top).offset(11);
        make.width.equalTo(34);
        make.bottom.equalTo(startView.bottom).offset(-9);
    }];
#pragma mark-- 倒三角 PickerDate1 约束
    // 时间选择按钮
    [triangle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startViewLabel3.right).offset(-4);
        make.top.equalTo(startView.top).offset(7);
        make.bottom.equalTo(startView.bottom).offset(-3);
        make.width.equalTo(@30);
    }];
    
    //PickerDate1 约束
    UIView *superView = self.view;
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(-1);
        make.right.equalTo(superView.right).offset(1);
        make.bottom.equalTo(superView.bottom).offset(-43);
        make.height.equalTo(@150);
    }];
    
    //alert1 约束
    [_alert1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.left).offset(10);
        make.right.equalTo(_backView.right).offset(-10);
        make.bottom.equalTo(_backView.bottom).offset(0);
        make.top.equalTo(_backView.top).offset(10);
    }];
    //datePicker 约束
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_alert1.left);
        make.right.equalTo(_alert1.right);
        make.top.equalTo(_alert1.top);
        make.bottom.equalTo(_alert1.bottom);
    }];
    //_alertbutton 约束
    [_alertbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView.right).offset(@-4);
        make.top.equalTo(_backView.top).offset(-23);
        make.width.equalTo(@45);
        make.height.equalTo(@20);
    }];
    
    //field1
    [_field1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(@20);
        make.right.equalTo(contentView.right).offset(@-20);
        make.top.equalTo(startView.bottom).offset(@20);
        make.height.equalTo(@30);
    }];
    //Label1
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(@20);
        make.right.equalTo(contentView.right).offset(@-20);
        make.top.equalTo(_field1.bottom);
        make.height.equalTo(@30);
    }];
    //field2
    [_field2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(@20);
        make.right.equalTo(contentView.right).offset(@-20);
        make.top.equalTo(_label1.bottom).offset(@20);
        make.height.equalTo(@30);
    }];
    //Label2
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(@20);
        make.right.equalTo(contentView.right).offset(@-20);
        make.top.equalTo(_field2.bottom);
        make.height.equalTo(@30);
    }];
    //endView
    [endView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(@-1);
        make.top.equalTo(_label2.bottom).offset(@10);
        make.right.equalTo(contentView.right).offset(@1);
        make.height.equalTo(40);
    }];
    //endViewLabel1
    [endViewLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(endView.left).offset(leftWid-30);
        make.top.equalTo(endView.top).offset(11);
        make.width.equalTo(32);
        make.bottom.equalTo(endView.bottom).offset(-9);
    }];
    [_endViewLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(endViewLabel1.right).offset(10);
        make.top.equalTo(endView.top).offset(11);
        make.width.equalTo(110);
        make.bottom.equalTo(endView.bottom).offset(-9);
    }];
    [endViewLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_endViewLabel2.right).offset(10);
        make.top.equalTo(endView.top).offset(11);
        make.width.equalTo(34);
        make.bottom.equalTo(endView.bottom).offset(-9);
    }];
#pragma mark--倒三角 PickerDate2 约束
    // 时间选择按钮
    [triangle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(endViewLabel3.right).offset(-4);
        make.top.equalTo(endView.top).offset(7);
        make.bottom.equalTo(endView.bottom).offset(-3);
        make.width.equalTo(@30);
    }];
    //PickerDate2
    //    UIView *superView = self.view;
    [_backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.left).offset(-1);
        make.right.equalTo(superView.right).offset(1);
        make.bottom.equalTo(superView.bottom).offset(-43);
        make.height.equalTo(@150);
    }];
    
    //alert2 约束
    [_alert2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView2.left).offset(10);
        make.right.equalTo(_backView2.right).offset(-10);
        make.bottom.equalTo(_backView2.bottom).offset(0);
        make.top.equalTo(_backView2.top).offset(10);
    }];
    //datePicker2 约束
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_alert2.left);
        make.right.equalTo(_alert2.right);
        make.top.equalTo(_alert2.top);
        make.bottom.equalTo(_alert2.bottom);
    }];
    //_alertbutton2 约束
    [_alertbutton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView2.right).offset(@-4);
        make.top.equalTo(_backView2.top).offset(-23);
        make.width.equalTo(@45);
        make.height.equalTo(@20);
    }];

    //Number约束
    int wid = (WIDTH - 8 - 20)/2;
    [_NumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.top.equalTo(endView.bottom).offset(@5);
        make.right.equalTo(contentView.right).offset(-wid+20);
        make.height.equalTo(40);
    }];
    //Days
    [DayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_NumberLabel.right).offset(@8);
        make.top.equalTo(endView.bottom).offset(@16);
        make.height.equalTo(18);
        make.width.equalTo(34);
    }];
    
    //imageButton约束
    [imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.left).offset(@20);
        make.right.equalTo(mainView.right).offset(@-20);
        make.top.equalTo(contentView.bottom).offset(@20);
        make.bottom.equalTo(mainView.bottom).offset(@-20);
    }];
}
#pragma mark ----PickerDate方法实现
//点击第一个倒三角触发的方法
- (void)triangleClick{
    [self.view bringSubviewToFront:_backView];
    _backView.hidden = NO;
    _alertbutton.hidden = NO;
    }
//改变第一个PickerDate触发的方法
- (void)dateChange:(id)sender{
    _control = (UIDatePicker*)sender;
    _date_before = _control.date;
    NSString *str = [MyControl DateIntoStrWithDate:_control.date];
    _startViewLabel2.text = str;
}
//第一个PickerDate 回收按钮触发的方法
- (void)alertButtonClick:(UIButton *)sender{
    //为隐藏第一个PickerDate添加动画
    [MyControl addAnimationWithID:_backView];
    _backView.hidden = YES;
    sender.hidden = YES;
}
#pragma mark ----PickerDate2点击方法实现
//点击第二个倒三角触发的方法
- (void)triangleClick2{
    [self.view bringSubviewToFront:_backView2];
    _backView2.hidden = NO;
    _alertbutton2.hidden = NO;
    }
//改变第二个PickerDate触发的方法
- (void)dateChange2:(id)sender{
    UIDatePicker *control = (UIDatePicker*)sender;
    //endView显示的日期
    _endViewLabel2.text = [MyControl DateIntoStrWithDate:control.date];
    //两个时间差除以每天的秒数并转化为字符串
    _NumberLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)[[MyControl StrIntoDateWithStr:_endViewLabel2.text] timeIntervalSinceDate:[MyControl StrIntoDateWithStr:_startViewLabel2.text]]/(60*60*24)];
}
//第二个PickerDate 回收按钮触发的方法
- (void)alertButton2Click:(UIButton *)sender{
    //为隐藏backView添加动画
    [MyControl addAnimationWithID:_backView2];
    _backView2.hidden = YES;
    sender.hidden = YES;
}
//底部大图片按钮点击触发的方法
- (void)ImgButtonClick{
    NSLog(@"点击了图片按钮");
}


//当textfield结束输入时调用 
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"结束编辑了！！！！");
    //第一个日期减上field里的天数得出的时期并显示在label1上
    _label1.text = [MyControl DateIntoStrWithDate:[[MyControl StrIntoDateWithStr:_startViewLabel2.text] dateByAddingTimeInterval:-[_field1.text integerValue]*24*60*60]];
    
    //第一个日期加上field里的天数得出的时期并显示在label2上
    _label2.text = [MyControl DateIntoStrWithDate:[[MyControl StrIntoDateWithStr:_startViewLabel2.text] dateByAddingTimeInterval:[_field2.text integerValue]*24*60*60]];
}
//UITextFieldDelegate相关方法
//使用view的touchesBegan:触摸事件来实现对键盘的隐藏，当点击view的区域就会触发这个事件(点击空白处自动隐藏键盘)
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_field1 resignFirstResponder];
    [_field2 resignFirstResponder];
}

@end
