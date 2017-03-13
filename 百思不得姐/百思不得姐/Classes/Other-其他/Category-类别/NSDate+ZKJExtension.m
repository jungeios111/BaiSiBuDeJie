//
//  NSDate+ZKJExtension.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/13.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "NSDate+ZKJExtension.h"

@implementation NSDate (ZKJExtension)

- (NSDateComponents *)deltaDateFrom:(NSDate *)from
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];
}

/**
 * 是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger createYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == createYear;
}

/**
 * 是否为今天
 */
- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowDate = [fmt stringFromDate:[NSDate date]];
    NSString *createDate = [fmt stringFromDate:self];
    return [nowDate isEqualToString:createDate];
}

/**
 * 是否为昨天
 */
- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *createDate = [fmt dateFromString:[fmt stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:nowDate options:0];
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

@end
