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
#import "ZKJTopicPictureView.h"
#import "ZKJTopicVoiceView.h"
#import "ZKJTopicVideoView.h"
#import "ZKJComment.h"
#import "ZKJUser.h"

@interface ZKJTopicCell ()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
/** 姓名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 关注 */
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaImgView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
/** 图片帖子中间显示的内容 */
@property (nonatomic, weak) ZKJTopicPictureView *pictureView;
/** 声音帖子中间显示的内容 */
@property (nonatomic, weak) ZKJTopicVoiceView *voiceView;
/** 视频帖子中间显示的内容 */
@property (nonatomic, weak) ZKJTopicVideoView *videoView;
/** 最热评论的整体view */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
/** 最热评论的内容label */
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation ZKJTopicCell

/**
 今年
    今天
        1分钟内
            刚刚
        1小时内
            xx分钟前
        其他
            xx小时前
    昨天
        昨天 18:56:34
    其他
        06-23 19:56:23
 
 非今年
    2014-05-08 18:45:30
 */

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (ZKJTopicPictureView *)pictureView
{
    if (!_pictureView) {
        ZKJTopicPictureView *pictureView = [ZKJTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (ZKJTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        ZKJTopicVoiceView *voiceView = [ZKJTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        self.voiceView = voiceView;
    }
    return _voiceView;
}

- (ZKJTopicVideoView *)videoView
{
    if (!_videoView) {
        ZKJTopicVideoView *videoView = [ZKJTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        self.videoView = videoView;
    }
    return _videoView;
}

- (void)setTopic:(ZKJTopic *)topic
{
    _topic = topic;
    
    // 新浪加V
    self.sinaImgView.hidden = !topic.isSina_v;
    
    // 设置头像
    [self.headImageView setHead_image:topic.profile_image];
    
    // 设置名字
    self.nameLabel.text = topic.name;
    
    // 设置帖子的创建时间
    self.timeLabel.text = topic.create_time;
    
    // 设置按钮文字
    [self setButton:self.dingBtn withCount:topic.ding withDefaultTitle:@"顶"];
    [self setButton:self.caiBtn withCount:topic.cai withDefaultTitle:@"踩"];
    [self setButton:self.shareBtn withCount:topic.repost withDefaultTitle:@"转发"];
    [self setButton:self.commentBtn withCount:topic.comment withDefaultTitle:@"评论"];
    
    // 帖子的文字内容
    self.text_Label.text = topic.text;
    
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == ZKJTopicTypePicture) {
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.picFrame;
        
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == ZKJTopicTypeVoice) {
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceFrame;
        
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == ZKJTopicTypeVideo) {
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoFrame;
        
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == ZKJTopicTypeWord) {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.commentLabel.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
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
    frame.origin.x = ZKJTopicCellMargin;
    frame.origin.y += ZKJTopicCellMargin;
    frame.size.width -= 2 * ZKJTopicCellMargin;
//    frame.size.height -= ZKJTopicCellMargin;
    frame.size.height = self.topic.cellHeight - ZKJTopicCellMargin;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imgView;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.headImageView.layer.cornerRadius = self.headImageView.width * 0.5;
//    self.headImageView.layer.masksToBounds = YES;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    self.text_Label.preferredMaxLayoutWidth = self.text_Label.bounds.size.width;
//}

/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)testDate:(NSString *)create_time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *nowDate = [NSDate date];
    NSDate *createDate = [fmt dateFromString:create_time];
    ZKJLog(@"%@", [nowDate deltaDateFrom:createDate]);
}

- (void)testDate
{
    // 日历
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //    // 比较时间
    //    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:nowDate options:0];
    //    ZKJLog(@"%@  --  %@", nowDate, createDate);
    //    ZKJLog(@"year:%zd  month:%zd  day:%zd  hour:%zd  minute:%zd  second:%zd", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    
    // 获得NSDate的每一个元素
    //    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:nowDate];
    //    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:nowDate];
    //    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:nowDate];
    //    ZKJLog(@"%zd %zd %zd", year, month, day);
    
    //    NSDateComponents *cmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:nowDate];
    //    ZKJLog(@"%zd %zd %zd", cmps.year, cmps.month, cmps.day);
}
 */

@end
