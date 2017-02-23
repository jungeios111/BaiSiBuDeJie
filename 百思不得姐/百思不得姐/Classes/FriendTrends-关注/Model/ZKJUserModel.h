//
//  ZKJUserModel.h
//  百思不得姐
//
//  Created by ZKJ on 2017/2/23.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKJUserModel : NSObject

/** 用户头像 */
@property(nonatomic,copy) NSString *header;
/** 推荐用户的昵称 */
@property(nonatomic,copy) NSString *screen_name;
/** 推荐用户的关注量 */
@property(nonatomic,copy) NSString *fans_count;
/** 是否关注 */
@property(nonatomic,assign) int is_follow;

@end
