//
//  ZKJRecommendTagsVC.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/28.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJRecommendTagsVC.h"
#import "ZKJRecommendTag.h"
#import "ZKJRecommendTagCell.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <AFNetworking.h>

@interface ZKJRecommendTagsVC ()

/** 数据 */
@property(nonatomic,strong) NSArray *tags;

@end

@implementation ZKJRecommendTagsVC

static NSString *cellName = @"tagCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化控件
    [self setUpTableView];
    
    // 请求数据
    [self sendRequestLoadData];
}

- (void)sendRequestLoadData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZKJLog(@"%@", responseObject);
        [SVProgressHUD dismiss];
        self.tags = [ZKJRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showWithStatus:@"加载数据失败!"];
    }];
}

/** 初始化控件 */
- (void)setUpTableView
{
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKJRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:cellName];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = ZKJGlobalBGColor;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKJRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    cell.model = self.tags[indexPath.row];
    return cell;
}




@end
