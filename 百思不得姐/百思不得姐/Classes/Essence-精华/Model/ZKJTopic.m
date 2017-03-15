//
//  ZKJTopic.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/10.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJTopic.h"

//@interface ZKJTopic ()
//{
//    CGFloat _cellHeight;
//}
//@end

@implementation ZKJTopic
{
    CGFloat _cellHeight;
}

/**
 今年
    今天
        1分钟内
            刚刚
        1小时内
            xx分钟前
        其他
            xx小时前
    昨天
        昨天 18:56:34
    其他
        06-23 19:56:23
 
 非今年
    2014-05-08 18:45:30
 */

- (NSString *)create_time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:_create_time];
    
    if (createDate.isThisYear) {
        // 今年
        if (createDate.isToday) {
            // 今天
            NSDateComponents *cmps = [[NSDate date] deltaDateFrom:createDate];
            if (cmps.hour >= 1) {
                // xx小时前
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) {
                // xx分钟前
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                // 刚刚
                return @"刚刚";
            }
        } else if (createDate.isYesterday) {
            // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createDate];
        } else {
            // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }
    } else {
        // 非今年
        return _create_time;
    }
    return nil;
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(ZKJScreenWidth - 4 * ZKJTopicCellMargin, MAXFLOAT);
        
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight = ZKJTopicCellTextY + textH + ZKJTopicCellMargin + ZKJTopicCellBottomBarH + ZKJTopicCellMargin;
        ZKJLogFunC;
    }
    return _cellHeight;
}

@end
