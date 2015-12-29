//
//  FirstCell.h
//  product
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath;
- (void)config:(NSString *)arr;
- (void)configWith:(NSString *)arr;
@end
