//
//  ViewRight.m
//  product
//
//  Created by JD -高 on 15/8/1.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "ViewRight.h"
#import "MyPathView.h"
#import "FirstCell.h"
#import "TongJiPathView.h"
#import "dateView.h"
@interface ViewRight () <UIScrollViewDelegate ,UITableViewDelegate ,UITableViewDataSource >

@property (nonatomic , retain) UISegmentedControl * segment;

@property (nonatomic , retain) UIScrollView * scrollView;
@property (nonatomic , copy) NSArray * arr;

@end

@implementation ViewRight

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        _arr = @[@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",@"24:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00"];
        
        NSArray * array = [NSArray arrayWithObjects:@"缩放",@"树状图",nil];
        _segment = [[UISegmentedControl alloc]initWithItems:array];
        [self addSubview:_segment];
        
        [_segment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(70);
            make.right.equalTo(self.right).offset(-70);
            make.top.equalTo(self.top).offset(10);
            make.height.equalTo(30);
        }];
        
        
        _segment.tintColor = [UIColor colorWithRed: 0.7529 green: 0.988 blue: 0.9267 alpha: 1.0];
//        默认选中位置
        _segment.layer.masksToBounds = YES;
        _segment.layer.cornerRadius = 15;
        _segment.layer.borderColor = [UIColor colorWithRed: 0.9005 green: 0.2207 blue: 0.8905 alpha: 1.0].CGColor;
        _segment.layer.borderWidth = 2;
        
        _segment.selectedSegmentIndex = 0;
        _segment.segmentedControlStyle = UISegmentedControlStyleBar;
        [_segment addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    
//        添加一个Scroview
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height - 50)];
        [_scrollView setContentSize:CGSizeMake(self.bounds.size.width * 2, self.bounds.size.height - 50)];
        [self addSubview:_scrollView];
        
//        去掉弹簧
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
//        添加分页
        _scrollView.pagingEnabled = YES;
//        添加scrollview的 协议
        _scrollView.delegate = self;
        
//        添加一个圆~(对象)
        UIView * roundView = [[UIView alloc]init];
        roundView.frame = CGRectMake(0,0,WIDTH-70,WIDTH-70);
        roundView.center = CGPointMake((WIDTH-40)/2, _scrollView.bounds.size.height/2 -30 );
        roundView.backgroundColor = [[UIColor colorWithRed:0.912 green:1.000 blue:0.735 alpha:0.700] colorWithAlphaComponent:1];
        roundView.layer.masksToBounds = YES;
        roundView.layer.cornerRadius = (WIDTH-70)/2;
        [_scrollView addSubview:roundView];
        
//        再圆上添加 datePicker
        dateView * date = [[dateView alloc]init];
        date.backgroundColor = [UIColor clearColor];
        date.layer.masksToBounds = YES;
        date.layer.cornerRadius = 15;
        date.layer.borderColor = [UIColor colorWithRed:1.000 green:0.715 blue:0.044 alpha:0.500].CGColor;
        date.layer.borderWidth = 2;
        [roundView addSubview:date];
        
//        datePicker标题
        UILabel * label =[WHController labelWithFrame:CGRectNull andFont:14.0f andtext:@"选择日期以查看历史记录"];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.5];
        [roundView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(date.left).offset(0);
            make.right.equalTo(date.right).offset(0);
            make.bottom.equalTo(date.top).offset(-2);
            make.height.equalTo(15);
        }];
        
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(roundView.left).offset(56);
            make.right.equalTo(roundView.right).offset(-56);
            make.top.equalTo(roundView.top).offset(100);
            make.bottom.equalTo(roundView.bottom).offset(-100);
        }];

        
//        统计View
        TongJiPathView * tongView = [[TongJiPathView alloc]init];
        [_scrollView addSubview:tongView];
        tongView.backgroundColor = [UIColor clearColor];
        [tongView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(roundView.left).offset(50);
            make.right.equalTo(roundView.right).offset(-50);
            make.top.equalTo(roundView.bottom).offset(5);
            make.bottom.equalTo(roundView.bottom).offset(80);
        }];
        
        
//        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(50, _scrollView.bounds.size.height - 30, 320, 30)];
//        label.text = @"长按金币可以添加事件提醒";
//        [_scrollView addSubview:label];
        
//        于第二个页面中添加一个tablView
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(_scrollView.bounds.size.width + 10,20, _scrollView.bounds.size.width - 20, _scrollView.bounds.size.height - 20) style:UITableViewStylePlain];
        [_scrollView addSubview:tableView];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        
//        画线的View
        MyPathView * pathView = [[MyPathView alloc]initWithFrame:CGRectMake(tableView.bounds.size.width/2, 30, 5, 950)];
        pathView.backgroundColor = [UIColor colorWithRed: 0.7939 green: 0.9684 blue: 1.0 alpha: 0.0];
        [tableView addSubview:pathView];
        

  
//        添加scroview的手势
        
//        让scrollView手势 失去之前的响应
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_scrollView addGestureRecognizer:tap];
        
    }
    return self;
}

#pragma mark -- UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 24;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    FirstCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"id1"];
    FirstCell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"id1"];
    
    if (cell1 == nil && indexPath.row %2) {
        
        cell1 = [[FirstCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id" andIndexPath:indexPath];
        cell1.accessoryType = UITableViewCellSelectionStyleNone;
        [cell1 config: [NSString stringWithFormat:@"%@", _arr[indexPath.row]]];
        return cell1;
        
    }else{
    
        cell2 = [[FirstCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id2"];
        cell1.accessoryType = UITableViewCellSelectionStyleNone;
        [cell2 configWith:_arr[indexPath.row]];
        return cell2;
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = indexPath.row % 2 ? [UIColor colorWithRed:0.577 green:0.000 blue:1.000 alpha:0.100] : [UIColor colorWithRed:0.000 green:0.726 blue:1.000 alpha:0.100] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    view.backgroundColor = [UIColor clearColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 250, 30)];
    label.text = @"点击可查看事件详情";
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{

}

#pragma mark -- scroview协议事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / self.bounds.size.width;
    NSLog(@"%f %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
//    Container的position
//getInnerContainer()->getPositionX()
    if (index == 0 && scrollView.contentOffset.y < 600) {
        _segment.selectedSegmentIndex = 0;
    }else{
        _segment.selectedSegmentIndex = 1;
    }
    
}

//segment点击事件
- (void)segmentedAction:(UISegmentedControl*)segment{
    
    NSInteger  index = segment.selectedSegmentIndex;
    if (index == 0 ) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if(index == 1){
        [_scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:YES];
    }
    
}

@end
