//
//  ZKJWordViewController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/9.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJWordViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "ZKJTopic.h"

@interface ZKJWordViewController ()

/** 帖子数据 */
@property(nonatomic,strong) NSMutableArray *topicArr;
/** maxtime */
@property(nonatomic,copy) NSString *maxtime;
/** 当前的页码 */
@property(nonatomic,assign) NSInteger page;
/** 上次请求的参数 */
@property(nonatomic,strong) NSDictionary *parameters;

@end

@implementation ZKJWordViewController

- (NSMutableArray *)topicArr
{
    if (!_topicArr) {
        _topicArr = [NSMutableArray array];
    }
    return _topicArr;
}

static NSString *cellName = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableView
    [self setUpTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    
}

// 初始化tableView
- (void)setUpTableView
{
    // 设置内边距
    CGFloat top = ZKJTitilesViewY + ZKJTitilesViewH;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellName];
}

/** 添加刷新控件 */
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark - 下拉刷新
- (void)loadNewData
{
    [self.tableView.mj_footer endRefreshing];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"29";
    self.parameters = parameters;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        if (self.parameters != parameters) return ;
        
        ZKJLog(@"%@", responseObject);
        
        self.topicArr = [ZKJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parameters != parameters) return ;
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 上拉加载更多
- (void)loadMoreData
{
    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"29";
    parameters[@"maxtime"] = self.maxtime;
    NSInteger page = self.page + 1;
    parameters[@"page"] = @(page);
    self.parameters = parameters;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        if (self.parameters != parameters) return ;
        
        ZKJLog(@"%@", responseObject);
        
        NSArray *newTopic = [ZKJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.topicArr addObjectsFromArray:newTopic];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
        // 设置页码
        self.page = page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parameters != parameters) return ;
        
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topicArr.count == 0);
    return self.topicArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    
    ZKJTopic *topic = self.topicArr[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    ZKJLog(@"%@", topic.text);
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    return cell;
}

@end
