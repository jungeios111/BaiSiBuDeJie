//
//  ZKJTopic.h
//  百思不得姐
//
//  Created by ZKJ on 2017/3/10.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKJTopic : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 帖子的类型 */
@property (nonatomic, assign) ZKJTopicType type;
/** 小图的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图的URL */
@property (nonatomic, copy) NSString *big_image;
/** 图片的宽 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高 */
@property (nonatomic, assign) CGFloat height;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/***** 额外的辅助属性 *****/
/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect picFrame;
/** 判断是否是大图 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 当前图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;
///** 当前图片的下载大小 */
//@property(nonatomic, assign) NSInteger receivedSize;
///** 图片的总大小 */
//@property(nonatomic, assign) NSInteger expectedSize;

/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceFrame;
/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoFrame;

@end
