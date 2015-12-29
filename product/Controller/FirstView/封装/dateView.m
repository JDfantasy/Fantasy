//
//  dateView.m
//  product
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "dateView.h"
@interface dateView () <UIPickerViewDelegate ,UIPickerViewDataSource>

@property (nonatomic , copy) UIPickerView * dateView;

@end

@implementation dateView

- (instancetype)init{

    if (self = [super init]) {
        _dateView = [[UIPickerView alloc]init];
        _dateView.delegate = self;
        _dateView.dataSource = self;
        [self addSubview:_dateView];
        
        [_dateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left);
            make.right.equalTo(self.right);
            make.top.equalTo(self.top);
            make.bottom.equalTo(self.bottom);
        }];
//        给pickerView选择默认的row  需要写在 pckerView 加载在父视图之后
//        和 数据之后
        [_dateView selectRow:1 inComponent:0 animated:YES];
    }
    return self;
}
#pragma mark -- 协议
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
//    NSDate * date = [NSDate date];
//    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
    return 3;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //    设置 时间格式~~
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY年 MM月 dd日";
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    NSString * strTime = [formatter stringFromDate:date];
//    通过空格 拆分 字符串
//    NSArray * arrString = [strTime componentsSeparatedByString:@" "];
    
    UILabel * label = [WHController labelWithFrame:CGRectNull andFont:22 andtext:strTime];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont boldSystemFontOfSize:22];
    label.textColor = [UIColor colorWithRed:0.467 green:0.486 blue:0.490 alpha:1.000];

    UIView * viewSuper = [[UIView alloc]init];
    label.frame = CGRectMake(0, 0, 220, 32);
    [viewSuper addSubview:label];

    
    //返回当前时间之后多少秒的时间
    NSDate * date1 = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
    formatter1.dateFormat = @"YYYY年 MM月 dd日";
    [formatter1 setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    NSString * strTime1 = [formatter1 stringFromDate:date1];
    
    //返回当前时间之后多少秒的时间
    NSDate * date2 = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
    NSDateFormatter * formatter2 = [[NSDateFormatter alloc]init];
    formatter2.dateFormat = @"YYYY年 MM月 dd日";
    [formatter2 setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    NSString * strTime2 = [formatter1 stringFromDate:date2];
    
    switch (row) {
        case 0:
            label.text = strTime2;
            label.textColor = [UIColor colorWithRed:0.8682 green:0.2476 blue:1.0 alpha:1.0];
            break;
        case 1:
            label.text = strTime;
            label.textColor = [UIColor colorWithRed:0.625 green:0.129 blue:1.000 alpha:1.000];
            break;
        case 2:
            label.text = strTime1;
            label.textColor = [UIColor colorWithRed:1.0 green:0.156 blue:0.0 alpha:1.0];
            break;
            
        default:
            break;
    }
    
    return viewSuper;
}

////返回当前行需要显示的内容 此处是将数组中的数值添加到滚动的那个显示栏上
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    
//    return _pickerData[row];
//}
//
////当选中某个row时调用
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    //    NSLog(@"title = %@",pickerView);
//    //    void(^changeLabel)(NSInteger Num)
//    if (_changeLabel) {
//        _changeLabel(row);
//    }
//    
//}

//widthForComponent
//返回每一列的 宽度 每一列为component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return WIDTH/2;
}
//各列的row的高度 component 从0开始
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 28;
}

//设置默认在compoent列中默认选中row行
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
    
}


@end
