//
//  WHController.h
//  product
//
//  Created by JD -高 on 15/7/19.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface WHController : NSObject

#pragma mark -- 创建 UIView的类方法
+ (UIView *)viewWithFrame:(CGRect)frame;

#pragma mark -- 创建 UILabel的类方法
+ (UILabel *)labelWithFrame:(CGRect)frame
                          andFont:(CGFloat)font
                          andtext:(NSString *)text;

#pragma mark -- 创建 UIImageView的类方法
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                             andImageName:(NSString *)text;

#pragma mark -- 创建 UIButton的类方法
+ (UIButton *)buttonWithFrame:(CGRect)frame
                          andTarget:(id)target
                          andMethod:(SEL)method
                       andImageName:(NSString *)imageName
                           andTitle:(NSString *)text;

@end
