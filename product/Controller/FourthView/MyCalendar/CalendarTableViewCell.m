//
//  CalendarTableViewCell.m
//  日历界面
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CalendarTableViewCell.h"
#import "CalendarLayout.h"
#import "SectionHeaderCollectionReusableView.h"
#import "NSDate+Calendar.h"
#import "CalendarCollectinViewCell.h"
#import "MyCalendarObject.h"

@interface CalendarTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray * dayModels;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) SectionHeaderCollectionReusableView *headerView;

@end

@implementation CalendarTableViewCell

static NSString * const reuseIdentifier = @"Cell";
static NSString * const sectionHeaderReuseIdentifier = @"SectionHeaderView";

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CalendarLayout *layout = [[CalendarLayout alloc] init];
#warning 坐标要改
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.top);
            make.left.equalTo(self.contentView.left);
            make.right.equalTo(self.contentView.right);
            make.bottom.equalTo(self.contentView.bottom);
        }];
        [self makeCollectionView];
    }
    return self;
}
- (void)makeCollectionView{

    _dayModels = [[NSDate date] getDayModelsInCurrentMonth];
    
    // Register cell classes
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[CalendarCollectinViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[SectionHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeaderReuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dayModels count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCollectinViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.dayModel = [_dayModels objectAtIndex:indexPath.item];
    //cell.dayLabel.backgroundColor = [UIColor clearColor];
    cell.hiddenPerAndNextMonthDay = YES;
    
    UISwipeGestureRecognizer * leftSwip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwip)];
    leftSwip.direction = UISwipeGestureRecognizerDirectionLeft;
    [cell addGestureRecognizer:leftSwip];
    
    UISwipeGestureRecognizer * rightSwip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwip)];
    rightSwip.direction = UISwipeGestureRecognizerDirectionRight;
    [cell addGestureRecognizer:rightSwip];
    
    return cell;
}
// 添加左划手势
- (void)leftSwip{

//    NSLog(@"左划");
    [_headerView getDatePerOrNextMonthWith:1];
}
- (void)rightSwip{

//    NSLog(@"右划");
    [_headerView getDatePerOrNextMonthWith:-1];
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SectionHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionHeaderReuseIdentifier forIndexPath:indexPath];
        // 上下月份 事件
        __weak CalendarTableViewCell *weakSelf = self;
        headerView.plusOrMinusMonthBlock = ^(NSDate *otherMonthDate){
            [weakSelf.dayModels removeAllObjects];
            weakSelf.dayModels = [otherMonthDate getDayModelsInCurrentMonth];
            [weakSelf.collectionView reloadData];
        };
        _headerView = headerView;
        return _headerView;
    }
    return nil;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCollectinViewCell *cell = (CalendarCollectinViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
//    NSLog(@"%@ - %@ - %@",cell.dayModel.year,cell.dayModel.month,cell.dayModel.day);
}



#pragma mark <UICollectionViewDelegate>


#pragma mark - item highlight

// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
