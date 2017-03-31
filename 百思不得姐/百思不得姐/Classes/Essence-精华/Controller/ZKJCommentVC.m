//
//  ZKJCommentVC.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/27.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJCommentVC.h"
#import "ZKJTopicCell.h"
#import "ZKJTopic.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "ZKJComment.h"
#import "ZKJUser.h"
#import <MJExtension.h>
#import "ZKJCommentHeadView.h"

@interface ZKJCommentVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

/** 工具条底部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;
/** 保存帖子的top_cmt */
@property (nonatomic, strong) NSArray *save_top_cmt;

@end

@implementation ZKJCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBasic];
    
    [self setUpHeaderView];
    
    [self setUpRefresh];
}

// 初始化刷新控件
- (void)setUpRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
}

// 设置顶部的view
- (void)setUpHeaderView
{
    // 清空top_cmt
    if (self.topic.top_cmt.count) {
        self.save_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    UIView *headerView = [[UIView alloc] init];
    
    ZKJTopicCell *cell = [ZKJTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(ZKJScreenWidth, self.topic.cellHeight);
    [headerView addSubview:cell];
    headerView.height = self.topic.cellHeight + ZKJTopicCellMargin;
    
    self.tableView.tableHeaderView = headerView;
}

// 初始化基本数据
- (void)setBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" andHighLightImage:@"comment_nav_item_share_icon_click" andTarget:self andAction:@selector(shareClick)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.backgroundColor = ZKJGlobalBGColor;
}

#pragma mark - 下拉刷新
- (void)loadNewComments
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZKJLog(@"responseObject:%@", responseObject);
        
        // 最热评论
        self.hotComments = [ZKJComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.latestComments = [ZKJComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)shareClick
{
    ZKJLogFunC;
}

- (void)keyboardFrameChange:(NSNotification *)note
{
    ZKJLog(@"note:%@", note);
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottomMargin.constant = ZKJScreenHeight - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 动画 及时刷新
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (hotCount) return 2;
    if (latestCount) return 1;
    return 0;
}

// 1:titleForHeaderInSection
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    return @"最新评论";
//}

// 2:viewForHeaderInSection
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headView = [[UIView alloc] init];
//    headView.backgroundColor = ZKJGlobalBGColor;
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = ZKJRGBColor(67, 67, 67);
//    label.x = ZKJTopicCellMargin;
//    label.width = 200;
//    label.textAlignment = NSTextAlignmentLeft;
//    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [headView addSubview:label];
//    
//    NSInteger count = self.hotComments.count;
//    if (section == 0) {
//        label.text = count ? @"最热评论" : @"最新评论";
//    } else {
//        label.text = @"最新评论";
//    }
//    
//    return headView;
//}

// 3
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static NSString *headID = @"head";
//    UITableViewHeaderFooterView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headID];
//    if (head == nil) {
//        head = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headID];
//        head.contentView.backgroundColor = ZKJGlobalBGColor;
//        
//        UILabel *label = [[UILabel alloc] init];
//        label.textColor = ZKJRGBColor(67, 67, 67);
//        label.textAlignment = NSTextAlignmentLeft;
//        label.frame = CGRectMake(ZKJTopicCellMargin, 0, 200, 30);
//        label.tag = 1;
//        [head.contentView addSubview:label];
//    }
//    
//    UILabel *label = (UILabel *)[head viewWithTag:1];
//    
//    NSInteger count = self.hotComments.count;
//    if (section == 0) {
//        label.text = count ? @"最热评论" : @"最新评论";
//    } else {
//        label.text = @"最新评论";
//    }
//    
//    return head;
//}

// 4
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZKJCommentHeadView *head = [ZKJCommentHeadView headViewWithTableView:tableView];
    NSInteger count = self.hotComments.count;
    if (section == 0) {
        head.title = count ? @"最热评论" : @"最新评论";
    } else {
        head.title = @"最新评论";
    }
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (ZKJComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    ZKJComment *comment = [self commentInIndexPath:indexPath];
    cell.textLabel.text = comment.content;
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 恢复帖子的top_cmt
    if (self.save_top_cmt.count) {
        self.topic.top_cmt = self.save_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
}

@end
