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

/** 标签栏底部的红色指示器 */
@property(nonatomic,weak) UIView *indicateView;
/** 当前选中的按钮 */
@property(nonatomic,weak) UIButton *selBtn;

@end

@implementation ZKJEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNavigationBar];
    
    // 设置顶部的标签栏
    [self setTopTitlesView];
}

/**
 * 设置顶部的标签栏
 */
- (void)setTopTitlesView
{
    // 标签栏整体
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 35)];
    topView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:topView];
    
    // 底部的红色指示器
    UIView *indicateView = [[UIView alloc] init];
    indicateView.backgroundColor = [UIColor redColor];
    indicateView.height = 2;
    indicateView.y = topView.height - indicateView.height;
    [topView addSubview:indicateView];
    self.indicateView = indicateView;
    
    // 内部的子标签
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"内涵段子"];
    CGFloat width = topView.width / titles.count;
    CGFloat height = topView.height;
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.x = i * width;
        btn.y = 0;
        btn.width = width;
        btn.height = height;
//        [btn layoutIfNeeded];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:btn];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            btn.enabled = NO;
            self.selBtn = btn;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [btn.titleLabel sizeToFit];
            self.indicateView.width = btn.titleLabel.width;
            self.indicateView.centerX = btn.centerX;
        }
    }
}

- (void)titleBtnClick:(UIButton *)btn
{
    ZKJLogFunC;
    // 修改按钮状态
    self.selBtn.enabled = YES;
    btn.enabled = NO;
    self.selBtn = btn;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicateView.width = btn.titleLabel.width;
        self.indicateView.centerX = btn.centerX;
    }];
}

/**
 * 设置导航栏
 */
- (void)setNavigationBar
{
    // 设置背景色
    self.view.backgroundColor = ZKJGlobalBGColor;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" andHighLightImage:@"MainTagSubIconClick" andTarget:self andAction:@selector(btnClick)];
}

- (void)btnClick
{
    ZKJRecommendTagsVC *vc = [[ZKJRecommendTagsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
