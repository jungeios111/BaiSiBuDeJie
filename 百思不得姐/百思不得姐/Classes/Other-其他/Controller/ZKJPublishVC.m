//
//  ZKJPublishVC.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/21.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJPublishVC.h"
#import "ZKJVerticalButton.h"

@interface ZKJPublishVC ()

@end

@implementation ZKJPublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *slogan = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    slogan.y = ZKJScreenHeight * 0.15;
    slogan.centerX = ZKJScreenWidth * 0.5;
    [self.view addSubview:slogan];
    
    // 数据
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    
    // 6个按钮
    int maxCols = 3;
    CGFloat btnW = 72.0;
    CGFloat btnH = btnW + 30;
    CGFloat btnStartX = 20;
    CGFloat btnStartY = ZKJScreenHeight * 0.5 - btnH;
    CGFloat colsMargen = (ZKJScreenWidth - 2 * btnStartX - 3 * btnW) / 2;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    int row = 0;
    int col = 0;
    for (NSInteger i = 0; i < titles.count; i++) {
        row = i / maxCols;
        col = i % maxCols;
        btnX = btnStartX + (btnW + colsMargen) * col;
        btnY = btnStartY + btnH * row;
        
        ZKJVerticalButton *btn = [ZKJVerticalButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)btn
{
    ZKJLogFunC;
}

- (IBAction)cancelClick
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
