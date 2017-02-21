//
//  ZKJMeViewController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/20.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJMeViewController.h"

@interface ZKJMeViewController ()

@end

@implementation ZKJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [setBtn setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [setBtn setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    setBtn.size = setBtn.currentBackgroundImage.size;
    [setBtn addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *moonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moonBtn setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [moonBtn setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    moonBtn.size = moonBtn.currentBackgroundImage.size;
    [moonBtn addTarget:self action:@selector(moonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:setBtn];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:moonBtn];
    self.navigationItem.rightBarButtonItems = @[item1, item2];
    
}

- (void)setClick
{
    ZKJLogFunC;
}

- (void)moonClick
{
    ZKJLogFunC;
}

@end
