//
//  MyView.h
//  Sunday
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 yanchao. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyControl : NSObject
//createView
+ (UIView *)createViewWithBackgroundColor:(UIColor *)color andRornerRadius:(CGFloat)RornerRadius andMasksToBounds:(BOOL)masksToBounds andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)borderColor;

//createAlertView
+ (UIAlertView *)createAlertViewWithBackgroundColor:(UIColor *)color andRornerRadius:(CGFloat)RornerRadius andMasksToBounds:(BOOL)masksToBounds andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)borderColor;

//createLabel
+ (UILabel *)createLabelWithText:(NSString *)test andTextColor:(UIColor *)textColor andTextAlignment:(NSTextAlignment)textAlignment andbackgroundColor:(UIColor *)backgroundColor andfont:(UIFont *)font;

//createButton
+(UIButton*)createButtonWithBackgroundColor:(UIColor *)backgroundColor target:(id)target method:(SEL)method normalImage:(UIImage *)normalImage andLightImage:(UIImage *)LightImage;

//DateIntoStr
+(NSString *)DateIntoStrWithDate:(NSDate *)Date;

//StrIntoDate
+(NSDate *)StrIntoDateWithStr:(NSString *)DateStr;


//ButtonSetCornerRadius
+(UIButton *)ButtonSetCornerRadiusWithButton:(UIButton*)button andCornerRadius:(CGFloat)cornerRadius andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)borderColor;

//createDatePicker
+(UIDatePicker *)createDatePickerWithTarget:(id)target andAction:(SEL)methed;

//andAnimation
+(void)addAnimationWithID:(id)ID;


@end
