//
//  ZKJCommentHeadView.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/31.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJCommentHeadView.h"

@interface ZKJCommentHeadView ()

/** label标签 */
@property (nonatomic, weak) UILabel *label;

@end

@implementation ZKJCommentHeadView

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headID = @"head";
    ZKJCommentHeadView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headID];
    if (head == nil) {
        head = [[ZKJCommentHeadView alloc] initWithReuseIdentifier:headID];
    }
    return head;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = ZKJGlobalBGColor;
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = ZKJRGBColor(67, 67, 67);
        label.font = [UIFont systemFontOfSize:15];
        label.frame = CGRectMake(ZKJTopicCellMargin, 0, 200, 30);
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text = title;
}


@end
