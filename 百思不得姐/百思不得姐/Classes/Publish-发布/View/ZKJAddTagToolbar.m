//
//  ZKJAddTagToolbar.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/12.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJAddTagToolbar.h"
#import "ZKJAddTagViewController.h"

@interface ZKJAddTagToolbar ()

/** 顶部的view */
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation ZKJAddTagToolbar

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 添加一个加号按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    btn.size = [UIImage imageNamed:@"tag_add_icon"].size;
//    btn.size = [btn imageForState:UIControlStateNormal].size;
    btn.size = btn.currentImage.size;
    btn.x = ZKJTagMargin;
    [self addSubview:btn];
}

- (void)btnClick
{
    ZKJAddTagViewController *tagVC = [[ZKJAddTagViewController alloc] init];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:tagVC animated:YES];
}

// a modal 出 b
// [a presentViewController:b animated:YES completion:nil];
// a.presentedViewController -> b
// b.presentingViewController -> a

@end
