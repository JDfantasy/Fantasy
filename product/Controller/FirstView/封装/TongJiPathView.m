//
//  TongJiPathView.m
//  product
//
//  Created by JD -高 on 15/8/1.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "TongJiPathView.h"

@implementation TongJiPathView

//    1获取图形上下文
- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    //    添加路径
//    CGPathMoveToPoint(path, nil, 0, -80 );
//    CGPathAddLineToPoint(path, nil, 0, 55);
    CGPathMoveToPoint(path, nil, 0, 0 );
    CGPathAddLineToPoint(path, nil, 0, 60);
    CGPathAddLineToPoint(path, nil, 180, 60);
    
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
    [self drawCurve:context];
    //    添加到上下文
    CGContextAddPath(context, path);
    //    渲染放到最后...添加完了才渲染
    //    渲染
    CGContextStrokePath(context);
    
}


#pragma mark 绘制贝塞尔曲线
-(void)drawCurve:(CGContextRef)context{
    
    
    /*绘制二次贝塞尔曲线
     c:图形上下文
     cpx:控制点x坐标
     cpy:控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
//    CGContextAddQuadCurveToPoint(context, 0, 0, 175, 100);
//    
//    //    重置context的初始位置~~否则会连着
//    CGContextMoveToPoint(context, 170,100);
//    CGContextAddQuadCurveToPoint(context, 360, 0,180, 300);
//    
    /*绘制三次贝塞尔曲线
     c:图形上下文
     cp1x:第一个控制点x坐标
     cp1y:第一个控制点y坐标
     cp2x:第二个控制点x坐标
     cp2y:第二个控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
//    绘制曲线
    CGContextMoveToPoint(context, 0, 30);//移动到起始位置
    CGContextAddCurveToPoint(context, 50, 0, 100, 70, 170,40);
//    CGContextMoveToPoint(context, 200,200);
//    CGContextAddCurveToPoint(context, 200, 200, 250, 100, 300, 200);
    //    设置图形上下文属性
    [[UIColor clearColor]setFill];
    [[UIColor redColor]setStroke];
    CGContextSetLineWidth(context, 3.0);//设置线条宽度
    CGContextSetLineJoin(context, kCGLineJoinRound);//设置连接点样式，(20,100)是连接点
    //绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end
