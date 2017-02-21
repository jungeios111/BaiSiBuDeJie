//
//  ZKJFriendTrendsController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/20.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJFriendTrendsController.h"

@interface ZKJFriendTrendsController ()

@end

@implementation ZKJFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" andHighLightImage:@"friendsRecommentIcon-click" andTarget:self andAction:@selector(btnClick)];
}

- (void)btnClick
{
    ZKJLogFunC;
}

@end
