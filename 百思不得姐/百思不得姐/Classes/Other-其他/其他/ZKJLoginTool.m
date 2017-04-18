//
//  ZKJLoginTool.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/17.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJLoginTool.h"
#import "ZKJLoginRegisterVC.h"

@implementation ZKJLoginTool

+ (void)setUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUid:(BOOL)isShowLoginVC
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    if (isShowLoginVC) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ZKJLoginRegisterVC *vc = [[ZKJLoginRegisterVC alloc] init];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
//        });
    }
    return uid;
}

+ (NSString *)getUid
{
    return [self getUid:NO];
}

@end
