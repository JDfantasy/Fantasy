//
//  NoteDetailViewController.m
//  product
//
//  Created by 程乔 on 15/7/30.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "SecVController.h"
@interface NoteDetailViewController ()<UIAlertViewDelegate>
@property UITextView *mytextView;
@end

@implementation NoteDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mytextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    NSArray * array = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSString * oldText = [array objectAtIndex:self.index];
    self.mytextView.text = oldText;
    
    UIImage *bgImage = [UIImage imageNamed:@"notebookbgimage.png"];
    self.mytextView.backgroundColor = [UIColor colorWithPatternImage:bgImage];


    
    UIBarButtonItem * saveButton = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonClicked:)];
    
    UIBarButtonItem * deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"delete" style:UIBarButtonItemStylePlain target:self action:@selector(deleteButtonClicked:)];
    
    NSArray * barArray = [NSArray arrayWithObjects:deleteButton,saveButton,nil];
    
    self.navigationItem.rightBarButtonItems = barArray;
    [self.view addSubview:self.mytextView];
    
}

- (void)saveButtonClicked:(UIButton *)send{

    NSArray * tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSMutableArray * mutableAarray = [tempArray mutableCopy];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate * now = [NSDate date];
    NSString * dateString = [dateFormatter stringFromDate:now];
    NSString * textString = [self.mytextView text];
    [mutableAarray removeObjectAtIndex:self.index];
    [mutableAarray insertObject:textString atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:mutableAarray forKey:@"note"];
    SecVController * secondVC = [[SecVController alloc] init];
    secondVC.noteArray = mutableAarray;
    
    NSArray * tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSMutableArray * mutableDateArray = [tempDateArray mutableCopy];
    [mutableDateArray removeObjectAtIndex:self.index];
    [mutableDateArray insertObject:dateString atIndex:0];
    secondVC.dateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    [self.mytextView resignFirstResponder];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"save success!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alertView show];

}

- (void)deleteButtonClicked:(UIButton *)send{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Are you sure to delete this note?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alertView show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        NSArray * tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
        NSMutableArray * mutableArray = [tempArray mutableCopy];
        [mutableArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
        
        SecVController * secondVC = [[SecVController alloc] init];
        secondVC.noteArray  = mutableArray;
        
        NSArray * tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
        NSMutableArray * mutableDateArray = [tempDateArray mutableCopy];
        [mutableDateArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
        secondVC.dateArray = mutableDateArray;
        [self.navigationController popViewControllerAnimated:YES];
    
    }else if (buttonIndex == 1) return;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
