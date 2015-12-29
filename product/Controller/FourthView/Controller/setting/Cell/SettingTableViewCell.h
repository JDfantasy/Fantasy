//
//  SettingTableViewCell.h
//  app_mechanics
//
//  Created by qianfeng on 15/7/24.
//  Copyright (c) 2015年 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingViewController;
@interface SettingTableViewCell : UITableViewCell

@property   (nonatomic, strong) UIImageView * imageView1;

@property   (nonatomic, strong) UIImageView * imageView2;

@property   (nonatomic, strong) UILabel * label;
@property (nonatomic) BOOL swichOpen;
@property (nonatomic, strong) SettingViewController * delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style string:(NSString*)str reuseIdentifier:(NSString *)reuseIdentifier;

-(void)setValueForCellWithstring:(NSString*)str image:(NSString*)imageName current_image:(NSString*)imageName_current reuseIdentifier:(NSString *)reuseIdentifier;

@end
