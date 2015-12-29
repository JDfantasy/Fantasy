//
//  SecVController.m
//  product
//
//  Created by JD -高 on 15/7/19.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "SecVController.h"
#import "NewNoteViewController.h"
#import "NoteDetailViewController.h"
@interface SecVController ()<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>

@property NSMutableArray * filteredNoteArray;
@property UISearchBar * searchBar;
@property UISearchDisplayController * searchDispView;

@end

@implementation SecVController
@synthesize noteArray,dateArray,filteredNoteArray,searchBar,searchDispView;


//---------------------------------------------
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.noteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    self.dateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    [self.tableView reloadData];
    
}
//-------------------------------------------

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNav];
    [self createSearchBar];
    // [self createTableView];
    
    //    设置navigationController的背景图片
    self.navigationController.navigationBar.translucent = NO;
    UIImage * image = [UIImage imageNamed:@"navbackImage.jpg"];
    //    UIImage * imageNew = [image scaleToSize:CGSizeMake(WIDTH, 64)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:23.0], NSForegroundColorAttributeName:[UIColor colorWithRed:0.7871 green:0.9665 blue:0.9559 alpha:1.0]}];
    UIImage *bgImage = [UIImage imageNamed:@"notebookbgimage.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    //self.tableView.tableHeaderView  = searchBar;
    

    
    
}
#pragma mark --创建一个searchBar
- (void)createSearchBar{
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    searchDispView = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    searchDispView.delegate = self;
    searchDispView.searchResultsDataSource = self;
    searchDispView.searchResultsDelegate = self;
    
    self.tableView.tableHeaderView = searchBar;
//    UIImage *bgImage = [UIImage imageNamed:@"notebookbgimage.png"];
   
    
  
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView  == self.searchDisplayController.searchResultsTableView) {
        
        return [filteredNoteArray count];
    }else return [noteArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIndentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIndentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString * note = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        note = [filteredNoteArray objectAtIndex:indexPath.row];
        
    }else if (tableView == self.tableView){
        
        note = [noteArray objectAtIndex:indexPath.row];
        
    }
    
    NSString * date = [dateArray objectAtIndex:indexPath.row];
    NSUInteger charnum = [note length];
    
    if (charnum < 22) {
        cell.textLabel.text = note;
        
    }else{
        
        cell.textLabel.text = [[note substringFromIndex:18] stringByAppendingString:@"..."];
        
    }
    cell.detailTextLabel.text = date;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    UIImage *bgImage = [UIImage imageNamed:@"notebookbgimage.png"];
    cell.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NoteDetailViewController * modifyVC = [[NoteDetailViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:modifyVC animated:YES];
    
    NSInteger row = [indexPath row];
    modifyVC.index = row;
    
}

#if 0
- (void)createTableView{
    
    UIView * superView =  self.view;
    
    
    //添加tableView
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectNull style:UITableViewStylePlain];
    //tableView.backgroundColor = [UIColor colorWithPatternImage:@"notebookbgimage.png"];
    [self.view addSubview:tableView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(superView.left).offset(10);
        make.right.equalTo(superView.right).offset(-10);
        make.top.equalTo(superView.top).offset(10);
        make.bottom.equalTo(superView.bottom).offset(-10);
        
        
        
    }];
    
    
    
    
}

#pragma makr -- TableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellEditingStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#endif




#pragma mark -- 设置navigationBar
- (void)setNav{
//    
//    //首先将View设置一个颜色便于分辨
//    self.view.backgroundColor = [UIColor whiteColor];
//    //关闭掉导航navigationBar的半透明状态,并且设置颜色
//    [self.navigationController.navigationBar setTranslucent:YES];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.800 green:0.400 blue:1.000 alpha:1.000]];
    
    //设置navigationBar的标题title
    self.title = @"NoteBook";
    
    //因为iOS7 navigationBar的标题系统默认的,所以需要修改系统参数(自定义参数)
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0],NSFontAttributeName,nil];
    
    //修改参数
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBarButtonClicked:)];
    
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareBarButtonClicked:)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}

- (void)addBarButtonClicked:(UIButton *)send{
    
    NSLog(@"addBarButtonClicked.......");
    self.hidesBottomBarWhenPushed = NO;
    NewNoteViewController * NewNoteVC = [[NewNoteViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:NewNoteVC animated:YES];
    
    
}

- (void)shareBarButtonClicked:(UIButton *)send{
    
    NSLog(@"shareBarButtonClicked.......");
}


#pragma mark uisearchdisplaydelegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    [filteredNoteArray removeAllObjects];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchString];
    NSArray * tempArray = [noteArray filteredArrayUsingPredicate:predicate];
    
    filteredNoteArray = [NSMutableArray arrayWithArray:tempArray];
    
    return YES;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
