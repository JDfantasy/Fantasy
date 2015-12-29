//
//  FirstFMDB.m
//  product
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import "FirstFMDB.h"

@implementation FirstFMDB

- (instancetype)initWithPath:(NSString *)inPath{

    if (self = [super initWithPath:inPath]) {
        if ([self open]) {
            NSLog(@"打开成功");
//            创建一个Data表单
            BOOL isSucceed = [self executeUpdate:@"create table buttonData(num,isClicked)"];
            if (isSucceed) {
                NSLog(@"创建成功");
//找地址
//      去某个东西
//        NSString *address = [db stringForQuery:@"SELECT Address FROM PersonList WHERE Name = ?",@"John”];
#pragma mark -- 初始化数据
                //    第一次 添加 32个数据
                for (int i = 0; i < 32; i++) {
                    NSLog(@"%d",i);
//                    NSNumber类型
                    [self executeUpdate:@"insert into buttonData values(? ?)",@"123",@"345"];
                    
                }
            }else{
                NSLog(@"创建失败");
            }
        }

        
        
    }
    return self;
}

@end
