//
//  AppDelegate.h
//  product
//
//  Created by JD -高 on 15/7/19.
//  Copyright (c) 2015年 JD -高. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainTabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate >{
    MainTabBarController * mainTab;
}
@property (strong) UITapGestureRecognizer *sideslipTapGes;

@property (strong, nonatomic) UIWindow *window;


@end

