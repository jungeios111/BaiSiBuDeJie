//
//  ZKJCategoryModel.h
//  百思不得姐
//
//  Created by ZKJ on 2017/2/23.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKJCategoryModel : NSObject

/** id */
@property(nonatomic,assign) NSInteger id;
/** 总数 */
@property(nonatomic,assign) NSInteger count;
/** 名字 */
@property(nonatomic,copy) NSString *name;

@end
