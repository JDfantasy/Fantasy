//
//  LeftPathView.m
//  product
//
//  Created by JD -高 on 15/8/1.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "LeftPathView.h"

@implementation LeftPathView

//    1获取图形上下文
- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    //    添加路径
//    CGPathMoveToPoint(path, nil, 85, 100);
    //    CGPathAddLineToPoint(path, nil, self.bounds.size.width, 0);

    [self drawCurve:context];
//    CGPathMoveToPoint(path, nil,1, 10);
//    CGPathAddLineToPoint(path, nil, 1, 60);
    
    
//    [self drawLinearGradient:context];
    //    [self drawRadialGradient:context];
    //    线宽//4.设置图形上下文状态属性

    


}
#pragma mark 绘制贝塞尔曲线
-(void)drawCurve:(CGContextRef)context{
    
    //绘制曲线
    CGContextMoveToPoint(context, self.bounds.size.width-1, 0);//移动到起始位置
    /*绘制二次贝塞尔曲线
     c:图形上下文
     cpx:控制点x坐标
     cpy:控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddQuadCurveToPoint(context, self.bounds.size.width/4, 1  , self.bounds.size.width/2, 5);
    CGContextClosePath(context);
//    CGContextClosePath
    CGContextMoveToPoint(context, self.bounds.size.width/2-1, 5);
    CGContextAddQuadCurveToPoint(context, self.bounds.size.width/2-9, 30  , self.bounds.size.width/2 -42,128);
    CGContextMoveToPoint(context, 1, 128);
    CGContextAddQuadCurveToPoint(context, 45, 117  , self.bounds.size.width-1, 117);
    CGContextMoveToPoint(context, self.bounds.size.width-1, 117);
    CGContextAddQuadCurveToPoint(context,-25, 50  ,self.bounds.size.width-1,1);
    
    CGContextClosePath(context);
    //设置填充色宽度
    CGContextSetLineWidth(context, 3);
    
    //    线宽//4.设置图形上下文状态属性
    CGContextSetRGBStrokeColor(context,0.3, 1, 0.8, 1);
    //设置笔触颜色 填充色

    CGContextSetRGBFillColor(context,0.8714, 0.8715, 0.8714, 0.5);
    
    
    //    kCGLineCapButt,
    //    kCGLineCapRound,
    //    kCGLineCapSquare
    CGContextSetLineCap(context, kCGLineCapRound);//设置顶点样式,（20,50）和（300,100）是顶点
    CGContextSetLineJoin(context, kCGLineJoinMiter);//设置连接点样式，(20,100)是连接点
    
    //5.绘制图像到指定图形上下文
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
    

    
    [[UIColor redColor]setFill];
    [[UIColor redColor]setStroke];
    
//    kCGPathFill,
//    kCGPathEOFill,
//    kCGPathStroke,
//    kCGPathFillStroke,
//    kCGPathEOFillStroke
    //绘制路径
    CGContextDrawPath(context, kCGPathStroke);
    
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
        208.0/255.0,86.0/255.0,186.0/255.0,1,
        0.7,1,1.0,1,
        0.5,1,0.2,1,
        1,0.5,1.0,1,
        
    };
    CGFloat locations[4]={0,0.3,0.7,1.0};
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
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        50.0,121.0,39.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
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
    CGContextDrawRadialGradient(context, gradient, CGPointMake(160, 284),0, CGPointMake(165, 289), 150, kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    //    CGColorSpaceRelease(colorSpace);
}
@end
