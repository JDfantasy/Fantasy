//
//  MyPathView.m
//  product
//
//  Created by JD -高 on 15/8/1.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "MyPathView.h"

@implementation MyPathView

//    1获取图形上下文
- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
//    添加路径
    CGPathMoveToPoint(path, nil, 5, 0);
    CGPathAddLineToPoint(path, nil, 5, 950);
    
    [self drawLinearGradient:context];
//    线宽//4.设置图形上下文状态属性
    CGContextSetRGBStrokeColor(context,0.3, 1, 0.8, 1);
    //设置笔触颜色 填充色
    CGContextSetRGBFillColor(context,0.5, 1.0, 0.5, 1);
    //设置填充色宽度
    CGContextSetLineWidth(context, 3);
//    颜色
    CGColorRef color = [UIColor yellowColor].CGColor;
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0.8, color);

//    CGContextDrawPath(context, kCGPathFillStroke);

//    添加到上下文
    CGContextAddPath(context, path);
//    渲染放到最后...添加完了才渲染
//    渲染
    CGContextStrokePath(context);

}
//
- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


#pragma mark 线性渐变
-(void)drawLinearGradient:(CGContextRef)context{
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[16]={
        168.0/255.0,150.0/255.0,157.0/255.0,1,
        209.0/255.0,127.0/255.0,127.0/255.0,1,
        0.5, 0.5237, 0.9237,1.0,
        0.1, 0.9237, 0.5237,1.0
    };
    CGFloat locations[4]={0,0.3,0.6,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 4);
    
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(320, 300), kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    //    CGColorSpaceRelease(colorSpace);
}
@end
