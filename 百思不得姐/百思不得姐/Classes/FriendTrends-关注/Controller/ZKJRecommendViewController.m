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
#import <MJExtension.h>
#import "ZKJCategoryCell.h"
#import "ZKJCategoryModel.h"
#import "ZKJRecommendUserCell.h"
#import "ZKJUserModel.h"
#import <MJRefresh.h>

#define ZkjCategorySelectRowModel self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row]

@interface ZKJRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边的分类表格 */
@property (strong, nonatomic) IBOutlet UITableView *categoryTableView;
/** 左边的分类数组 */
@property(nonatomic,strong) NSArray *categoryArray;
/** 右边的用户表格 */
@property (strong, nonatomic) IBOutlet UITableView *userTableView;
/** 请求参数 */
@property(nonatomic,strong) NSMutableDictionary *parameters;
/** AFN请求管理者 */
@property(nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation ZKJRecommendViewController

static NSString *categoryCellName = @"category";
static NSString *userCellName = @"user";

/** AFN请求管理者 */
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setUpTableView];
    
    // 添加刷新控件
    [self setUpRefresh];
    
    // 加载左侧的类别数据
    [self loadCategoryData];
}

/** 控件的初始化 */
- (void)setUpTableView
{
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = ZKJGlobalBGColor;
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKJCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryCellName];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKJRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userCellName];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
}

/** 添加刷新控件 */
- (void)setUpRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

#pragma mark - 下拉刷新
- (void)loadNewUsers
{
    ZKJCategoryModel *model = ZkjCategorySelectRowModel;
    
    // 设置当前页码为1
    model.currentPage = 1;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(model.id);
    parameters[@"page"] = @(model.currentPage);
    self.parameters = parameters;
    
    // 发送请求给服务器, 加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZKJLog(@"%@", responseObject);
        
        // 字典数组 -> 模型数组
        NSArray *userArray = [ZKJUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清除所有旧数据
        [model.userArray removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [model.userArray addObjectsFromArray:userArray];
        
        // 保存总数
        model.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.parameters != parameters) return ;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFootState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 不是最后一次请求
        if (self.parameters != parameters) return ;
        
        // 提醒加载失败
        [SVProgressHUD showWithStatus:@"加载失败!"];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}

#pragma mark - 上拉加载更多
- (void)loadMoreUsers
{
    ZKJCategoryModel *model = ZkjCategorySelectRowModel;
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(model.id);
    parameters[@"page"] = @(++model.currentPage);
    self.parameters = parameters;
    ZKJLog(@"%@", parameters);
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZKJLog(@"%@", responseObject);
        // 字典数组 -> 模型数组
        NSArray *userArray = [ZKJUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [model.userArray addObjectsFromArray:userArray];
        
        // 不是最后一次请求
        if (self.parameters != parameters) return ;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 让底部控件结束刷新
        [self checkFootState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 不是最后一次请求
        if (self.parameters != parameters) return ;
        
        // 提醒
        [SVProgressHUD showWithStatus:@"加载失败!"];
        
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 加载左侧的类别数据
- (void)loadCategoryData
{
    [SVProgressHUD showWithStatus:@"正在加载,请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        // 字典数组转模型数组
        self.categoryArray = [ZKJCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [self.categoryTableView reloadData];
        // 默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 左边的类别数据
    if (tableView == self.categoryTableView) return self.categoryArray.count;
    
    // 监测footer的状态
    [self checkFootState];
    
    // 右边的用户数据
    return [ZkjCategorySelectRowModel userArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        ZKJCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellName];
        cell.categoryModel = self.categoryArray[indexPath.row];
        return cell;
    } else {
        ZKJRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellName];
        cell.userModel = [ZkjCategorySelectRowModel userArray][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        [self.userTableView.mj_footer endRefreshing];
        
        ZKJCategoryModel *model = self.categoryArray[indexPath.row];
        // 显示曾经的数据
        if (model.userArray.count > 0) {
            [self.userTableView reloadData];
        } else {
            // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
            [self.userTableView reloadData];
            
            // 进入下拉刷新状态
            [self.userTableView.mj_header beginRefreshing];
        }
    }
}

/** 时刻监测footer的状态 */
- (void)checkFootState
{
    ZKJCategoryModel *model = ZkjCategorySelectRowModel;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (model.userArray.count == 0);
    
    // 让底部控件结束刷新
    if (model.userArray.count == model.total) {
        // 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        // 还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}

@end
