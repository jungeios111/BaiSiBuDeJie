//
//  ZKJMeViewController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/20.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJMeViewController.h"
#import "ZKJMeCell.h"
#import "ZKJMeFooterView.h"

@interface ZKJMeViewController ()

/** <#注释#> */
@property (nonatomic, strong) ZKJMeFooterView *footView;

@end

@implementation ZKJMeViewController

static NSString *cellName = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpTableView];
}

- (void)setUpTableView
{
    // 设置背景色
//    self.tableView.frame = CGRectMake(0, 0, ZKJScreenWidth, ZKJScreenHeight-44);
    self.tableView.backgroundColor = ZKJGlobalBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ZKJMeCell class] forCellReuseIdentifier:cellName];
//    self.tableView.sectionHeaderHeight = 0.01;
//    self.tableView.sectionFooterHeight = ZKJTopicCellMargin;
//    self.tableView.contentInset = UIEdgeInsetsMake(ZKJTopicCellMargin - 35, 0, 0, 0);
    ZKJMeFooterView *footView = [[ZKJMeFooterView alloc] init];
    self.footView = footView;
//    self.tableView.tableFooterView = [[ZKJMeFooterView alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.footView setNeedsDisplay];
    ZKJLog(@"%@", NSStringFromCGRect(self.tableView.frame));
}

- (void)setUpNav
{
    self.navigationItem.title = @"我的";
    // 设置背景色
    self.view.backgroundColor = ZKJGlobalBGColor;
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:@"mine-setting-icon" andHighLightImage:@"mine-setting-icon-click" andTarget:self andAction:@selector(setClick)];
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImage:@"mine-moon-icon" andHighLightImage:@"mine-moon-icon-click" andTarget:self andAction:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[item1, item2];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ZKJTopicCellMargin;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return self.footView.height+750;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return self.footView;
    }
    return nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    ZKJMeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    } else {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

- (void)setClick
{
    ZKJLogFunC;
}

- (void)moonClick
{
    ZKJLogFunC;
}

@end
