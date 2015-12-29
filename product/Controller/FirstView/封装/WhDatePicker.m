//
//  WhDatePicker.m
//  product
//
//  Created by JD -高 on 15/7/26.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "WhDatePicker.h"

@implementation WhDatePicker

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        //设置时区
        [self setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
        //设置显示模式
        [self setDatePickerMode:UIDatePickerModeDate];
        //设置显示格式

        //默认根据手机本地设置显示为中文 Or其他
        NSLocale * locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        self.locale = locale;
    }
    return self;
}

@end
