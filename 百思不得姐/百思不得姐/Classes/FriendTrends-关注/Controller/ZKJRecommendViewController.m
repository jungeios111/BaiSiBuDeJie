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

@interface ZKJRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边的分类tableview */
@property (strong, nonatomic) IBOutlet UITableView *categoryTableView;
/** 左边的分类数组 */
@property(nonatomic,strong) NSArray *categoryArray;

@end

@implementation ZKJRecommendViewController

static NSString *categoryCellName = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = ZKJGlobalBGColor;
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKJCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryCellName];
    
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
//        ZKJLog(@"categoryArray:\n%@", self.categoryArray);
        //刷新表格
        [self.categoryTableView reloadData];
        //默认显示第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKJCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellName];
    cell.categoryModel = self.categoryArray[indexPath.row];
    return cell;
}

@end
