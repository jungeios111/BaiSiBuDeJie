//
//  ZKJEssenceController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/20.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJEssenceController.h"
#import "ZKJRecommendTagsVC.h"
#import "ZKJAllViewController.h"
#import "ZKJVideoViewController.h"
#import "ZKJVoiceViewController.h"
#import "ZKJPictureViewController.h"
#import "ZKJWordViewController.h"

@interface ZKJEssenceController ()<UIScrollViewDelegate>

/** 标签栏底部的红色指示器 */
@property(nonatomic,weak) UIView *indicateView;
/** 当前选中的按钮 */
@property(nonatomic,weak) UIButton *selBtn;
/** 顶部的标签view */
@property(nonatomic,weak) UIView *titleView;
/** 展示内容的scrollView */
@property(nonatomic,weak) UIScrollView *scrollView;

@end

@implementation ZKJEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNavigationBar];
    
    // 初始化子控制器
    [self setChildViewController];
    
    // 设置顶部的标签栏
    [self setTopTitlesView];
    
    // 设置内容view
    [self setContentView];
}

/** 添加子控制器 */
- (void)setChildViewController
{
    ZKJAllViewController *all = [[ZKJAllViewController alloc] init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    ZKJVideoViewController *video = [[ZKJVideoViewController alloc] init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    ZKJVoiceViewController *voice = [[ZKJVoiceViewController alloc] init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    ZKJPictureViewController *picture = [[ZKJPictureViewController alloc] init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    ZKJWordViewController *word = [[ZKJWordViewController alloc] init];
    word.title = @"内涵段子";
    [self addChildViewController:word];
}

/**
 * 设置顶部的标签栏
 */
- (void)setTopTitlesView
{
    // 标签栏整体
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, ZKJTitilesViewY, self.view.width, ZKJTitilesViewH)];
    topView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:topView];
    self.titleView = topView;
    
    // 底部的红色指示器
    UIView *indicateView = [[UIView alloc] init];
    indicateView.backgroundColor = [UIColor redColor];
    indicateView.height = 2;
    indicateView.tag = -1;
    indicateView.y = topView.height - indicateView.height;
    self.indicateView = indicateView;
    
    // 内部的子标签
    CGFloat width = topView.width / self.childViewControllers.count;
    CGFloat height = topView.height;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.x = i * width;
        btn.y = 0;
        btn.width = width;
        btn.height = height;
        btn.tag = i;
//        [btn layoutIfNeeded];
        [btn setTitle:[self.childViewControllers[i] title] forState:UIControlStateNormal];
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
    [topView addSubview:indicateView];
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
    
    CGPoint offSet = self.scrollView.contentOffset;
    offSet.x = btn.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offSet animated:YES];
}

/** 内容view（中间的scrollView） */
- (void)setContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, 0);
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - UIScrollViewDelegate
// 滚动动画停止时执行,代码改变时出发,也就是setContentOffset改变时，不是人为拖拽scrollView导致滚动完毕，会调用scrollViewDidEndScrollingAnimation这个方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    ZKJLogFunC;
    // 计算当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;                              // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height;         // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleBtnClick:self.titleView.subviews[index]];
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
