//
//  ZKJPictureViewController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/9.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJPictureViewController.h"

@interface ZKJPictureViewController ()

@end

@implementation ZKJPictureViewController

static NSString *cellName = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableView
    [self setUpTableView];
}

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.backgroundColor = [UIColor grayColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ ------- %zd", [self class], indexPath.row];
    return cell;
}

@end
