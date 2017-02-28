//
//  ZKJRecommendTag.h
//  百思不得姐
//
//  Created by ZKJ on 2017/2/28.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKJRecommendTag : NSObject

/** 图片 */
@property(nonatomic,copy) NSString *image_list;
/** 名字 */
@property(nonatomic,copy) NSString *theme_name;
/** 订阅数 */
@property(nonatomic,assign) NSInteger sub_number;

@end
