//
//  ZKJProgressView.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/20.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJProgressView.h"

@implementation ZKJProgressView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString *proStr = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [proStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
