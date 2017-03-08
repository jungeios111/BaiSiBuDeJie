//
//  ZKJPushGuideView.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/8.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJPushGuideView.h"

@implementation ZKJPushGuideView

+ (instancetype)pushGuideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sandBoxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sandBoxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        ZKJPushGuideView *pushView = [ZKJPushGuideView pushGuideView];
        pushView.frame = window.bounds;
        [window addSubview:pushView];
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)closeClick
{
    [self removeFromSuperview];
}


@end
