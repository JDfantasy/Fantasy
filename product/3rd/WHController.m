//
//  WHController.m
//  product
//
//  Created by JD -高 on 15/7/19.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "WHController.h"

@implementation WHController

+ (UIView *)viewWithFrame:(CGRect)frame{
    
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.layer.masksToBounds = YES;
    return view;
}

#pragma mark -- 创建 UILabel的类方法
+ (UILabel *)labelWithFrame:(CGRect)frame
                          andFont:(CGFloat)font
                          andtext:(NSString *)text{
    
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:font];
//    自动换行属性
    label.numberOfLines = 0;
    label.layer.masksToBounds = YES;
    label.text = text;
    return label;

}

#pragma mark -- 创建 UIImageView的类方法
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                             andImageName:(NSString *)text{
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:text];
    
    return imageView;
}

#pragma mark -- 创建 UIButton的类方法
+ (UIButton *)buttonWithFrame:(CGRect)frame
                          andTarget:(id)target
                          andMethod:(SEL)method
                       andImageName:(NSString *)imageName
                           andTitle:(NSString *)text{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.layer.masksToBounds = YES;
    if (imageName) {
//        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (text) {
        [button setTitle:text forState:UIControlStateNormal];
    }
    [button addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
