//
//  ZKJTopicPictureView.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/15.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJTopicPictureView.h"
#import "ZKJTopic.h"
#import <UIImageView+WebCache.h>
#import "ZKJShowPictureVC.h"
#import "ZKJProgressView.h"

@interface ZKJTopicPictureView ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *bs_imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigImageBtn;
@property (weak, nonatomic) IBOutlet ZKJProgressView *progressView;

@end

@implementation ZKJTopicPictureView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加监听器
    self.bs_imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)];
    [self.bs_imageView addGestureRecognizer:tap];
}

- (void)showBigPicture
{
    ZKJShowPictureVC *vc = [[ZKJShowPictureVC alloc] init];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setTopic:(ZKJTopic *)topic
{
    _topic = topic;
    
    self.progressView.hidden = YES;
    
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
#warning 图片下载进度条显示bug（cell循环利用时显示其他图片的进度）
    // 设置图片
    [self.bs_imageView sd_setImageWithURL:[NSURL URLWithString:topic.big_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        // 计算进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:topic.pictureProgress animated:NO];
//        ZKJLog(@"%f", topic.pictureProgress);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
//        ZKJLog(@"%f", topic.pictureProgress);
        
        // 如果是大图片, 才需要进行绘图处理
        if (topic.isBigPicture == NO) return ;
        
        UIGraphicsBeginImageContextWithOptions(topic.picFrame.size, YES, 0.0);
        CGFloat width = topic.picFrame.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        self.bs_imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }];
    
//    if (self.bs_imageView.image == nil) {
//        self.progressView.hidden = NO;
//    } else {
//        self.progressView.hidden = YES;
//    }
    
    /**
     在不知道图片扩展名的情况下, 如何知道图片的真实类型?
     * 取出图片数据的第一个字节, 就可以判断出图片的真实类型
     */
    // gif是否隐藏
    NSString *extension = [topic.big_image pathExtension];
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否显示"点击查看全图"
    if (topic.isBigPicture) {
        self.seeBigImageBtn.hidden = NO;
    } else {
        self.seeBigImageBtn.hidden = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self showBigPicture];
}

@end
