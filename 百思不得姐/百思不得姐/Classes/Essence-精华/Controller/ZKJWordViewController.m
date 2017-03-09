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

@interface ZKJWordViewController ()

/** 帖子数据 */
@property(nonatomic,strong) NSArray *wordArray;

@end

@implementation ZKJWordViewController

static NSString *cellName = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    [self setUpDate];
}

- (void)setUpDate
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"29";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        ZKJLog(@"%@", responseObject);
        self.wordArray = responseObject[@"list"];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)setUpTableView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        cell.backgroundColor = [UIColor grayColor];
    }
    
    NSDictionary *dic = self.wordArray[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    cell.detailTextLabel.text = dic[@"text"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"profile_image"]] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    return cell;
}

@end
