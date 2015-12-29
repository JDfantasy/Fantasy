//
//  GoldView.m
//  product
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "GoldView.h"

@implementation GoldView


-(instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 5;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 400 * (WIDTH/320);
        

        
    }
    
    return self;

}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGMutablePathRef path = CGPathCreateMutable();

    [self drawRadialGradient:context];
  //  [self drawLinearGradient:context];
}

#pragma mark 线性渐变
-(void)drawLinearGradient:(CGContextRef)context{
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    CGFloat compoents[24]={
        248.0/255.0,16.0/255.0,16.0/255.0,1,
        248.0/255.0,286.0/255.0,286.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        250.0/255,244.0/255.0,239.0/255.0,1.0,
        150.0/255,50.0/255.0,239.0/255.0,1.0,
        250.0/255,244.0/255.0,239.0/255.0,1.0,
    };
    CGFloat locations[6]={0,0.2,0.3,0.5,0.7,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 6);
    
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
    CGFloat compoents[32]={
        248.0/255.0,216.0/255.0,80.0/255.0,1,
        
        248.0/255.0,0/255.0,256.0/255.0,1,
        
        20.0/255,244.0/255.0,239.0/255.0,1.0,
        
        45.0/255.0,127.0/255.0,250/255.0,1,
        
        250.0/255,244.0/255.0,239.0/255.0,1.0,
        150.0/255,50.0/255.0,239.0/255.0,1.0,
        250.0/255,244.0/255.0,239.0/255.0,1.0,
        20.0/255,244.0/255.0,239.0/255.0,1.0,
    };
    [UIColor colorWithRed: 0.821 green: 0.99 blue: 1 alpha: 1.0];
    CGFloat locations[8]={0.20,0.40,0.60,0.7,0.82,0.9,0.96,0.99};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 8);
    
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
    CGContextDrawRadialGradient(context, gradient, CGPointMake((self.bounds.size.width - WIDTH)/2 + self.center.x, self.bounds.size.height/2),0, CGPointMake((self.bounds.size.width - WIDTH)/2 + self.center.x, self.bounds.size.height/2), 460, kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    //    CGColorSpaceRelease(colorSpace);
}


- (void)click:(UIButton *)button{

}

@end
