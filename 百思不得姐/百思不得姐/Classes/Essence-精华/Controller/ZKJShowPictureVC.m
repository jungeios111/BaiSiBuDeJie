//
//  ZKJShowPictureVC.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/20.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJShowPictureVC.h"
#import <UIImageView+WebCache.h>
#import "ZKJTopic.h"
#import <SVProgressHUD.h>
#import "ZKJProgressView.h"

@interface ZKJShowPictureVC ()

/** scrollView */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** imageView */
@property(nonatomic,weak) UIImageView *imageView;
/** 进度条 */
@property (weak, nonatomic) IBOutlet ZKJProgressView *progressView;

@end

@implementation ZKJShowPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [imageView addGestureRecognizer:tap];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 给scrollView添加点击手势，图片过小时点击scrollView可以dismiss
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [self.scrollView addGestureRecognizer:tap1];
    
    // 图片尺寸
    CGFloat imageW = ZKJScreenWidth;
    CGFloat imageH = imageW * self.topic.height / self.topic.width;
    if (imageH > ZKJScreenHeight) {
        // 图片显示高度超过一个屏幕, 需要滚动查看
        imageView.frame = CGRectMake(0, 0, imageW, imageH);
        self.scrollView.contentSize = CGSizeMake(0, imageH);
    } else {
        imageView.size = CGSizeMake(imageW, imageH);
        imageView.centerY = ZKJScreenHeight * 0.5;
    }
    
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:self.topic.pictureProgress animated:NO];
    
    // 下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.big_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveClick
{
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完毕"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        ZKJLog(@"保存失败");
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        ZKJLog(@"保存成功");
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self backClick];
}

- (IBAction)shareClick
{
    ZKJLogFunC;
}

@end
