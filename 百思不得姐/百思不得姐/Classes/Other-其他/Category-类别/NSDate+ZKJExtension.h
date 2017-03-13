//
//  NSDate+ZKJExtension.h
//  百思不得姐
//
//  Created by ZKJ on 2017/3/13.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZKJExtension)

/** 比较日期 */
- (NSDateComponents *)deltaDateFrom:(NSDate *)from;

/** 是否为今年 */
- (BOOL)isThisYear;

/** 是否为今天 */
- (BOOL)isToday;

/** 是否为昨天 */
- (BOOL)isYesterday;

@end
