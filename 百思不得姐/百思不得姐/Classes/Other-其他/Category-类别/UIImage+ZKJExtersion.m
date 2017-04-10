//
//  UIImage+ZKJExtersion.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/10.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "UIImage+ZKJExtersion.h"

@implementation UIImage (ZKJExtersion)

- (UIImage *)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得当前图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
