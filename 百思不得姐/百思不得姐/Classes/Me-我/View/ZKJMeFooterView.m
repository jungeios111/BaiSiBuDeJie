//
//  ZKJMeFooterView.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/10.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJMeFooterView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "ZKJMeModel.h"
#import "ZKJSquareButton.h"
#import "ZKJWebViewController.h"

@implementation ZKJMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"a"] = @"square";
        parameters[@"c"] = @"topic";
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            ZKJLog(@"responseObject:\n%@", responseObject);
            NSArray *listArray = [ZKJMeModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            // 创建方块
            [self createSquare:listArray];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
}

/** 创建方块 */
- (void)createSquare:(NSArray *)array
{
    // 一行最多4列
    int maxCols = 4;
    
    CGFloat buttonW = ZKJScreenWidth / maxCols;
    CGFloat buttonH = buttonW;
    for (NSInteger i = 0; i < array.count; i++) {
        ZKJSquareButton *btn = [ZKJSquareButton buttonWithType:UIButtonTypeCustom];
        btn.model = array[i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        // 计算frame
        int row = i / maxCols;
        int col = i % maxCols;
        btn.x = col * buttonW;
        btn.y = row * buttonH;
        btn.width = buttonW;
        btn.height = buttonH;
    }
    
    // 计算总行数
//    NSUInteger totalRow = array.count / maxCols;
//    if (array.count % maxCols) {
//        totalRow++;
//    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    NSUInteger totalRow = (array.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = totalRow * buttonH;
//    ZKJLog(@"%f --- %zd", self.height, totalRow);
    
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)btnClick:(ZKJSquareButton *)btn
{
    if (![btn.model.url hasPrefix:@"http"]) return;
    
    ZKJWebViewController *webvc = [[ZKJWebViewController alloc] init];
    webvc.url = btn.model.url;
    webvc.title = btn.model.name;
    
    // 取出当前的导航控制器
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
    [nav pushViewController:webvc animated:YES];
//    ZKJLog(@"%@", [UIApplication sharedApplication].keyWindow.rootViewController);
//    ZKJLog(@"%@", tabBarVC.selectedViewController);
}

@end
