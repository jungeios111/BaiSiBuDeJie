//
//  ZKJTopicCell.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/10.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJTopicCell.h"
#import "ZKJTopic.h"
#import <UIImageView+WebCache.h>

@interface ZKJTopicCell ()

/** 头像 */
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
/** 姓名 */
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
/** 关注 */
@property (strong, nonatomic) IBOutlet UIButton *attentionBtn;
/** 顶 */
@property (strong, nonatomic) IBOutlet UIButton *dingBtn;
/** 踩 */
@property (strong, nonatomic) IBOutlet UIButton *caiBtn;
/** 分享 */
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
/** 评论 */
@property (strong, nonatomic) IBOutlet UIButton *commentBtn;

@end

@implementation ZKJTopicCell

- (void)setTopic:(ZKJTopic *)topic
{
    _topic = topic;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.timeLabel.text = topic.create_time;
    
    // 设置按钮文字
    [self setButton:self.dingBtn withCount:topic.ding withDefaultTitle:@"顶"];
    [self setButton:self.caiBtn withCount:topic.cai withDefaultTitle:@"踩"];
    [self setButton:self.shareBtn withCount:topic.repost withDefaultTitle:@"转发"];
    [self setButton:self.commentBtn withCount:topic.comment withDefaultTitle:@"评论"];
}

- (void)setButton:(UIButton *)button withCount:(NSInteger)count withDefaultTitle:(NSString *)defaultTitle
{
    if (count > 10000) {
        defaultTitle = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        defaultTitle = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:defaultTitle forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imgView;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
