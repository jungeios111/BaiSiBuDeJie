//
//  ZKJTopicViewController.h
//  百思不得姐
//
//  Created by JM on 16/3/16.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZKJTopicTypeAll = 1,
    ZKJTopicTypePicture = 10,
    ZKJTopicTypeWord = 29,
    ZKJTopicTypeVoice = 31,
    ZKJTopicTypeVideo = 41,
} ZKJTopicType;

@interface ZKJTopicViewController : UITableViewController

/** 帖子类型 */
@property (nonatomic, assign) ZKJTopicType type;

@end
