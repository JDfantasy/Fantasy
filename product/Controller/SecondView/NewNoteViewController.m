//
//  NewNoteViewController.m
//  product
//
//  Created by 程乔 on 15/7/30.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "NewNoteViewController.h"
#import "SecVController.h"

@interface NewNoteViewController ()
@property UITextView * myTextView;

@end

@implementation NewNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        //Custom  initialization
    }
    
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNav];
    
    self.myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:_myTextView.frame];
    bgImageView.image = [UIImage imageNamed:@"notebookbgimage.png"];
    self.myTextView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:bgImageView];
    
    [self.view addSubview:self.myTextView];
    [self.myTextView becomeFirstResponder];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:nil action:@selector(editEnded:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}



- (void)setNav{
    
    //首先将View设置一个颜色便于分辨
    self.view.backgroundColor = [UIColor whiteColor];
    //关闭掉导航navigationBar的半透明状态,并且设置颜色
    [self.navigationController.navigationBar setTranslucent:YES];
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.800 green:0.400 blue:1.000 alpha:1.000]];
    
    //设置navigationBar的标题title
    self.navigationItem.title = @"新增事件";
    
    //因为iOS7 navigationBar的标题系统默认的,所以需要修改系统参数(自定义参数)
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:19.0],NSFontAttributeName,nil];
    
    //修改参数
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editEnded:(UIButton *)send{
    
    NSMutableArray * initNoteArray = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"note"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initNoteArray forKey:@"note"];
    }
    NSArray * tempNoteArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"note"];
    
    //将数组存储到可变数组中
    NSMutableArray * mutableNoteArray = [tempNoteArray mutableCopy];
    NSString * textString = [self.myTextView text];
    [mutableNoteArray insertObject:textString atIndex:0];
    SecVController * secondVC = [[SecVController alloc] init];
    secondVC.noteArray = mutableNoteArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableNoteArray forKey:@"note"];
    
    NSMutableArray * initDateArray = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"date"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initDateArray forKey:@"date"];
    }
    
    NSArray * tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSMutableArray * mutableDateArray = [tempDateArray mutableCopy];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate * now = [NSDate date];
    NSString * dateString = [dateFormatter stringFromDate:now];
    [mutableDateArray insertObject:dateString atIndex:0];
    secondVC.dateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    [self.myTextView resignFirstResponder];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"添加成功!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    
    
    NSLog(@"edit having down");
}


@end
