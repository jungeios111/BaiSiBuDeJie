//
//  ZKJCategoryModel.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/23.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJCategoryModel.h"
#import <MJExtension.h>

@implementation ZKJCategoryModel

- (NSMutableArray *)userArray
{
    if (!_userArray) {
        _userArray = [NSMutableArray array];
    }
    return _userArray;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

@end
