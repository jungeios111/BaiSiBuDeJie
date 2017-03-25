//
//  ZKJTopicVoiceView.h
//  百思不得姐
//
//  Created by JM on 16/3/16.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZKJTopic;
@interface ZKJTopicVoiceView : UIView

+ (instancetype)voiceView;

/** 帖子模型 */
@property (nonatomic, strong) ZKJTopic *topic;

@end
