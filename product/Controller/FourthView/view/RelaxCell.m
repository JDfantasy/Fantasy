//
//  RelaxCell.m
//  日历界面1
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RelaxCell.h"
#import "MyControl.h"
@interface RelaxCell()
{

    UILabel * titleLabel;
    UIView * view;
}
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) UILabel * contentLabel;

@end


@implementation RelaxCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        self.backgroundColor = [UIColor lightGrayColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self makeSubviews];
    }
    return self;
}
- (void)makeSubviews{

    view = self.contentView;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed: 0.5723 green: 0.5723 blue: 0.5723 alpha: 0.5].CGColor;
    
    titleLabel = [MyControl createLabelWithText:@"轻松一刻" andTextColor:[UIColor blackColor] andTextAlignment:NSTextAlignmentLeft andbackgroundColor:[UIColor whiteColor] andfont:[UIFont systemFontOfSize:18]];
    [self.contentView addSubview:titleLabel];
    UIButton *button = [MyControl createButtonWithBackgroundColor:[UIColor whiteColor] target:self method:@selector(buttonClick) normalImage:nil andLightImage:nil];
    [button setTitle:@"换一个" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor colorWithWhite:0.000 alpha:0.600]
                 forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    
    UILabel * lineLabe = [[UILabel alloc]init];
    lineLabe.backgroundColor = [UIColor colorWithRed: 0.5723 green: 0.5723 blue: 0.5723 alpha: 0.5];
    [self.contentView addSubview:lineLabe];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.numberOfLines = 0;

    NSString * plistPath = [[NSBundle mainBundle]pathForResource:@"joke" ofType:@"plist"];
    _array = [[NSArray alloc]initWithContentsOfFile:plistPath];
    NSString * str = [NSString stringWithFormat:@"       %@",_array[0]];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.text = str;
    _contentLabel.textColor = [UIColor colorWithWhite:0.000 alpha:0.600];
    CGFloat height = [self adjustHeightWithString:str];
    [self.contentView addSubview:_contentLabel];
    
//--------------约束
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(7);
        make.right.equalTo(self.right).offset(-7);
        make.top.equalTo(self.top).offset(7);
        make.bottom.equalTo(_contentLabel.bottom).offset(4);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@(20));
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.equalTo(@(70));
        make.height.equalTo(@(20));
    }];
    [lineLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(2);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@(1));
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@(height));
    }];
}

- (void)buttonClick{

    static int i = 1;
    if (i == _array.count) {
        i = 0;
    }
    NSString * str = [NSString stringWithFormat:@"       %@",_array[i++]];

    _contentLabel.text = str;

    
}
- (CGFloat)adjustHeightWithString:(NSString*)str{

    // 创建UIFont
    UIFont * font = [UIFont systemFontOfSize:15.0];
    // 创建一个字典
    NSDictionary * fontDict = @{NSFontAttributeName:font};
    // 第二个参数  NSStringDrawingUsesLineFragmentOrigin
    // 第三个参数  字典
    // 第四个参数  nil
    CGRect labelRect = [str boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    // CGRect(结构体)中又包含了CGSize（也是结构体）中包含了width、height
    // CGSize
    CGSize labelSize = labelRect.size;
    // height
    CGFloat labelHeight = labelSize.height;
    return labelHeight;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
