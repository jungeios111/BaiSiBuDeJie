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
    // 设置背景色
    self.view.backgroundColor = ZKJGlobalBGColor;
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:@"mine-setting-icon" andHighLightImage:@"mine-setting-icon-click" andTarget:self andAction:@selector(setClick)];
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImage:@"mine-moon-icon" andHighLightImage:@"mine-moon-icon-click" andTarget:self andAction:@selector(moonClick)];
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
