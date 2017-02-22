//
//  ZKJRecommendViewController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/22.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface ZKJRecommendViewController ()

@end

@implementation ZKJRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = ZKJGlobalBGColor;
    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        ZKJLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

@end
