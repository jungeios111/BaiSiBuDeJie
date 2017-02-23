//
//  ZKJRecommendUserCell.h
//  百思不得姐
//
//  Created by ZKJ on 2017/2/23.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKJUserModel;

@interface ZKJRecommendUserCell : UITableViewCell

/** 推荐关注用户数据模型 */
@property(nonatomic,strong) ZKJUserModel *userModel;

@end
