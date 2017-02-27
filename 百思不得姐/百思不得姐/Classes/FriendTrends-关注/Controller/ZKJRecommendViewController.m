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

@interface ZKJRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边的分类表格 */
@property (strong, nonatomic) IBOutlet UITableView *categoryTableView;
/** 左边的分类数组 */
@property(nonatomic,strong) NSArray *categoryArray;
/** 右边的用户表格 */
@property (strong, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation ZKJRecommendViewController

static NSString *categoryCellName = @"category";
static NSString *userCellName = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setUpTableView];
    
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

/** 加载左侧的类别数据 */
- (void)loadCategoryData
{
    [SVProgressHUD showWithStatus:@"正在加载,请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        //字典数组转模型数组
        self.categoryArray = [ZKJCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.categoryTableView reloadData];
        //默认显示第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self tableView:self.categoryTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {      // 左边的类别数据
        return self.categoryArray.count;
    } else {                                        // 右边的用户数据
        // 左边被选中的类别模型
        ZKJCategoryModel *model = self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row];
        return model.userArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        ZKJCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellName];
        cell.categoryModel = self.categoryArray[indexPath.row];
        return cell;
    } else {
        ZKJRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellName];
        ZKJCategoryModel *model = self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row];
        cell.userModel = model.userArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        ZKJCategoryModel *model = self.categoryArray[indexPath.row];
        // 显示曾经的数据
        if (model.userArray.count > 0) {
            [self.userTableView reloadData];
        } else {
            // 发送请求给服务器, 加载右侧的数据
            [SVProgressHUD showWithStatus:@"正在加载,请稍后..."];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"a"] = @"list";
            parameters[@"c"] = @"subscribe";
            parameters[@"category_id"] = @(model.id);
            [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [SVProgressHUD dismiss];
                NSArray *userArray = [ZKJUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                [model.userArray addObjectsFromArray:userArray];
                [self.userTableView reloadData];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD showWithStatus:@"加载失败!"];
            }];
        }
    }
}


@end
