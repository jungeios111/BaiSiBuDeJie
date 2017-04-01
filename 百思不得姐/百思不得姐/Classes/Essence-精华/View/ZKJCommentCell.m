//
//  ZKJCommentCell.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/31.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJCommentCell.h"
#import <UIImageView+WebCache.h>
#import "ZKJComment.h"
#import "ZKJUser.h"

@interface ZKJCommentCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
/** 性别 */
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 点赞数 */
@property (weak, nonatomic) IBOutlet UILabel *zanCountLabel;
/** 声音按钮 */
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation ZKJCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.voiceButton.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    self.voiceButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setComment:(ZKJComment *)comment
{
    _comment = comment;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexImageView.image = [comment.user.sex isEqualToString:ZKJUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.nameLabel.text = comment.user.username;
    self.contentLabel.text = comment.content;
    self.zanCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = ZKJTopicCellMargin;
    frame.size.width -= 2 * ZKJTopicCellMargin;
    [super setFrame:frame];
}

@end
