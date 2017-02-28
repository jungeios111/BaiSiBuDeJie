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
/** 存放这个类别下右边用户的数据 */
@property(nonatomic,strong) NSMutableArray *userArray;
/** 总条数 */
@property(nonatomic,assign) NSInteger total;
/** 当前页码 */
@property(nonatomic,assign) NSInteger currentPage;

@end
