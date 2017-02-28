//
//  ZKJEssenceController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/20.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJEssenceController.h"
#import "ZKJRecommendTagsVC.h"

@interface ZKJEssenceController ()

@end

@implementation ZKJEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景色
    self.view.backgroundColor = ZKJGlobalBGColor;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" andHighLightImage:@"MainTagSubIconClick" andTarget:self andAction:@selector(btnClick)];
}

- (void)btnClick
{
    ZKJLogFunC;
    ZKJRecommendTagsVC *vc = [[ZKJRecommendTagsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
