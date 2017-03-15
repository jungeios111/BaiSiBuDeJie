//
//  ZKJTopic.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/10.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJTopic.h"
#import <MJExtension.h>

//@interface ZKJTopic ()
//{
//    CGFloat _cellHeight;
//}
//@end

@implementation ZKJTopic
{
    CGFloat _cellHeight;
    CGFloat picFrame;
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

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"small_image" : @"image0",
             @"middle_image" : @"image1",
             @"big_image" : @"image2"};
}

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
        
        // 计算cell的高度
        // 文字部分的高度
        _cellHeight = ZKJTopicCellTextY + textH + ZKJTopicCellMargin;
        
        // 根据段子的类型来计算cell的高度
        if (self.type == ZKJTopicTypePicture) {
            
            // 计算图片的frame
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = pictureW * self.height / self.width;
            CGFloat pictureX = ZKJTopicCellMargin;
            CGFloat pictureY = ZKJTopicCellTextY + textH + ZKJTopicCellMargin;
            _picFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            // 判断是否是大图
            if (pictureH > ZKJTopicCellPictureMaxH) {
                pictureH = ZKJTopicCellPictureBreakH;
                self.bigPicture = YES;
            }
            
            // 图片部分的高度
            _cellHeight += pictureH + ZKJTopicCellMargin;
        } else if (self.type == ZKJTopicTypeVoice) {
            
        }
        
        _cellHeight += ZKJTopicCellBottomBarH + ZKJTopicCellMargin;
        
        ZKJLogFunC;
    }
    return _cellHeight;
}

@end
