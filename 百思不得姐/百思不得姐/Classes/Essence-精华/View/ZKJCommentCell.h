//
//  ZKJCommentCell.h
//  百思不得姐
//
//  Created by ZKJ on 2017/3/31.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZKJComment;
@interface ZKJCommentCell : UITableViewCell

/** 评论数据模型 */
@property (nonatomic, strong) ZKJComment *comment;

@end
