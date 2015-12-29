//
//  RightDownView.m
//  product
//
//  Created by qianfeng on 15/8/2.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "RightDownView.h"

@implementation RightDownView

//    1获取图形上下文
- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawRadialGradient:context];
    //    渲染放到最后...添加完了才渲染
}
//

#pragma mark 径向渐变
-(void)drawRadialGradient:(CGContextRef)context{
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
//    0.000,1.000,0.277
//    0.852,1.000,0.670,1,
    CGFloat compoents[8]={
        0.700,1.000,0.527,1,
        0.891,1.000,0.151,1,
    };
    [UIColor colorWithRed:0.717 green:1.000 blue:0.535 alpha:1.000];
    CGFloat locations[2]={0.7,0.9};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 2);
    
    /*绘制径向渐变
     context:图形上下文
     gradient:渐变色
     startCenter:起始点位置
     startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
     endCenter:终点位置（通常和起始点相同，否则会有偏移）
     endRadius:终点半径（也就是渐变的扩散长度）
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
     */
    CGContextDrawRadialGradient(context, gradient, CGPointMake(self.bounds.size.width/2 , self.bounds.size.width/2 ),0, CGPointMake(self.bounds.size.width/2 , self.bounds.size.width/2), self.bounds.size.width/2 , kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    //    CGColorSpaceRelease(colorSpace);
}

@end
