//
//  FirstCell.m
//  product
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "FirstCell.h"
#import "LinePathView.h"

@interface FirstCell ()

@property (nonatomic , retain)UILabel * label1;
@property (nonatomic , retain)UILabel * label2;

@end

@implementation FirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        LinePathView * lineView = [[LinePathView alloc]initWithFrame:CGRectMake( self.bounds.size.width/2, 20, 20, 5)];
        lineView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:lineView];
        
        _label2 = [[UILabel alloc]init];
        _label2.textColor = [UIColor colorWithRed: 0.8374 green: 0.8374 blue: 0.8374 alpha: 1.0];
        [self.contentView addSubview:_label2];
        
        [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineView.right).offset(5);
            make.right.equalTo(lineView.right).offset(50);
            make.top.equalTo(self.contentView.top).offset(10);
            make.height.equalTo(25);
        }];
        
    }
    return self;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        LinePathView * lineView = [[LinePathView alloc]initWithFrame:CGRectMake( self.bounds.size.width/2 - 20, 20, 20, 5)];
        lineView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:lineView];

        _label1 = [[UILabel alloc]init];
        _label1.textColor = [UIColor colorWithRed: 0.8374 green: 0.8374 blue: 0.8374 alpha: 1.0];
        [self.contentView addSubview:_label1];
        [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineView.left).offset(-45);
            make.right.equalTo(lineView.left).offset(0);
            make.top.equalTo(self.contentView.top).offset(10);
            make.height.equalTo(25);;
        }];
            
            
        
    }
    return self;
}

- (void)config:(NSString *)arr{
    _label1.text =  arr;
}
- (void)configWith:(NSString *)arr{
    _label2.text =arr;
}

- (void)click:(UIButton *)button{
    
    NSLog(@"1");
    // 动画执行开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
//    设置动画时间
    [UIView setAnimationDuration:0.8];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:button cache:YES];
    
//    button.frame = CGRectMake(300, -140, 40, 40);
    button.alpha = 0.3;
    // 执行动画
    [UIView commitAnimations];
    
}


@end
