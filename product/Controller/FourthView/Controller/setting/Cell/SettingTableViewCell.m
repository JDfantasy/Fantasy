//
//  SettingTableViewCell.m
//  app_mechanics
//
//  Created by qianfeng on 15/7/24.
//  Copyright (c) 2015年 vincent. All rights reserved.
//
#define WIDTH_OF_CELL self.contentView.frame.size.width
#define HEIGHT_OF_CELL 60

#import "SettingTableViewCell.h"
#import "SettingViewController.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style string:(NSString*)str reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _label = [[UILabel alloc] init];
        _imageView1 = [[UIImageView alloc] init];
        _imageView2 = [[UIImageView alloc] init];
        if ([str isEqualToString:@"调节亮度"]) {
            UISwitch * switchButton = [[UISwitch alloc] init];
            [switchButton setOn:YES];
            [self.contentView addSubview:switchButton];
            [switchButton makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView.mas_right).offset(-20);
                make.width.equalTo(@40);
                make.top.equalTo(self.contentView.mas_top).offset(20);
                make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
            }];
//            self.accessoryView = switchButton;
            [switchButton addTarget:self action:@selector(swichClick) forControlEvents:UIControlEventValueChanged];
            [switchButton  setOn:!_swichOpen];
            
        }else{
            _imageView2.image = [UIImage imageNamed:@"weidu.png"];
        }
        [self.contentView addSubview:_imageView2];
        
        [_imageView2 makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.width.equalTo(@20);
            make.top.equalTo(self.contentView.mas_top).offset(20);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        }];
        

        
    }
    return self;
}


-(void)setValueForCellWithstring:(NSString*)str image:(NSString*)imageName current_image:(NSString*)imageName_current reuseIdentifier:(NSString *)reuseIdentifier {
    _label.frame = CGRectMake(HEIGHT_OF_CELL , 10, WIDTH_OF_CELL - 20, HEIGHT_OF_CELL - 20);
    _label.text = str;
    _imageView1.frame = CGRectMake(10, 10, HEIGHT_OF_CELL - 20, HEIGHT_OF_CELL - 20);
    _imageView1.image = [UIImage imageNamed:imageName];
    [self.contentView addSubview:_label];
    [self.contentView addSubview:_imageView1];

}
- (void)swichClick{
    
//    NSLog(@"改变亮度");
    [self.delegate changeBrightness];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
