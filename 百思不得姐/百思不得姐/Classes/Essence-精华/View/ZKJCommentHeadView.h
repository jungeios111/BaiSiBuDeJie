//
//  ZKJCommentHeadView.h
//  百思不得姐
//
//  Created by ZKJ on 2017/3/31.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKJCommentHeadView : UITableViewHeaderFooterView

/** title文字 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end
