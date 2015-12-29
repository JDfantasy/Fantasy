//
//  UIImage+Scale.h
//  JD -高--考试
//
//  Created by JD -高 on 15/7/23.
//  Copyright (c) 2015年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

- (UIImage*)scaleToSize:(CGSize)size;

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

@end
