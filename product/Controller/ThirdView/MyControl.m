//
//  MyView.m
//  Sunday
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 yanchao. All rights reserved.
//

#import "MyControl.h"

@implementation MyControl

//createView
+ (UIView *)createViewWithBackgroundColor:(UIColor *)color andRornerRadius:(CGFloat)RornerRadius andMasksToBounds:(BOOL)masksToBounds andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)borderColor{
    
    UIView * View = [[UIView alloc]init];
    View.backgroundColor = color;
    //圆角设置
    View.layer.masksToBounds = masksToBounds;
    View.layer.cornerRadius = RornerRadius;
    View.layer.borderWidth = borderWidth;
    View.layer.borderColor = borderColor.CGColor;
    
    return View;
}

//createAlertView
+ (UIAlertView *)createAlertViewWithBackgroundColor:(UIColor *)color andRornerRadius:(CGFloat)RornerRadius andMasksToBounds:(BOOL)masksToBounds andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)borderColor{
    
    UIAlertView * View = [[UIAlertView alloc]init];
    View.backgroundColor = color;
    //圆角设置
    View.layer.masksToBounds = masksToBounds;
    View.layer.cornerRadius = RornerRadius;
    View.layer.borderWidth = borderWidth;
    View.layer.borderColor = borderColor.CGColor;
    
    return View;
}

//createLabel
+ (UILabel *)createLabelWithText:(NSString *)test andTextColor:(UIColor *)textColor andTextAlignment:(NSTextAlignment)textAlignment andbackgroundColor:(UIColor *)backgroundColor andfont:(UIFont *)font{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = test;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.backgroundColor = backgroundColor;
    label.font = font;
    
    return label;
}

//createButton
+(UIButton*)createButtonWithBackgroundColor:(UIColor *)backgroundColor target:(id)target method:(SEL)method normalImage:(UIImage *)normalImage andLightImage:(UIImage *)LightImage{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:LightImage forState:UIControlStateHighlighted];
    [button addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

//DateIntoStr
+(NSString *)DateIntoStrWithDate:(NSDate *)Date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"HKT"];
    NSString *str = [dateFormatter stringFromDate:Date];
    return str;
}

//StrIntoDate
+(NSDate *)StrIntoDateWithStr:(NSString *)DateStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"HKT"];
    NSDate *date = [dateFormatter dateFromString:DateStr];
    return date;
}

//ButtonSetCornerRadius
+(UIButton *)ButtonSetCornerRadiusWithButton:(UIButton*)button andCornerRadius:(CGFloat)cornerRadius andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)borderColor{
    
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = borderWidth;
    button.layer.borderColor = borderColor.CGColor;
    
    return button;
}

//createDatePicker
+(UIDatePicker *)createDatePickerWithTarget:(id)target andAction:(SEL)methed{
    
    UIDatePicker * datePicker = [[UIDatePicker alloc]init];
    //设置日期选择控件的地区
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    //设置DatePicker的日历, 默认为当天。
    [datePicker setCalendar:[NSCalendar currentCalendar]];
    //设置DatePicker的显示格式
    datePicker.datePickerMode = UIDatePickerModeDate;
    //设置DatePicker的时区。
    [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"HKT"]];
    //UIDatePicker需要监听值的改变
    [datePicker addTarget:target action:methed forControlEvents:UIControlEventValueChanged];
    
    return datePicker;
}

//andAnimation
+(void)addAnimationWithID:(id)ID{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    animation.duration = 0.3;
    [ID addAnimation:animation forKey:nil];
}
@end
