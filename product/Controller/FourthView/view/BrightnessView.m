//
//  BrightnessView.m
//  product
//
//  Created by qianfeng on 15/8/2.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "BrightnessView.h"

@implementation BrightnessView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

static BrightnessView * halfView = nil;
+ (id)sharedSingleClass {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        halfView = [[BrightnessView alloc] init];
    });
    return  halfView;
}

@end
