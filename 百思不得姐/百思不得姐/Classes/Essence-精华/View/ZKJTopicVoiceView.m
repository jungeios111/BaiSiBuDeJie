//
//  ZKJTopicVoiceView.m
//  百思不得姐
//
//  Created by JM on 16/3/16.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJTopicVoiceView.h"
#import <UIImageView+WebCache.h>
#import "ZKJTopic.h"
#import "ZKJShowPictureVC.h"

@interface ZKJTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *bs_imageView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation ZKJTopicVoiceView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加监听器
    self.bs_imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)];
    [self.bs_imageView addGestureRecognizer:tap];
}

- (void)showPicture
{
    ZKJShowPictureVC *vc = [[ZKJShowPictureVC alloc] init];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(ZKJTopic *)topic
{
    _topic = topic;
    [self.bs_imageView sd_setImageWithURL:[NSURL URLWithString:topic.big_image]];
    self.countLabel.text = [NSString stringWithFormat:@"%zd次播放", topic.playcount];
//    NSInteger hour = 0;
    NSInteger min = topic.voicetime / 60;
    NSInteger sec = topic.voicetime % 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd : %02zd", min, sec];
}

@end
