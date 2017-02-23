//
//  UIImage+ZKJExtension.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/23.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "UIImage+ZKJExtension.h"

@implementation UIImage (ZKJExtension)

+ (UIImage *)imageWithClipImageName:(NSString *)name
{
    // 1.加载图片
    UIImage *image = [UIImage imageNamed:name];
    
    // 2.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    // 3.添加圆形裁剪区域，并正切于图片
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [path addClip];
    
    // 4.绘制图片
    [image drawAtPoint:CGPointZero];
    
    // 5.从当前上下文获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭当前上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
}

+ (UIImage *)imageWithClipImage:(UIImage *)image
{
    // 1.加载图片
//    UIImage *image = [UIImage imageNamed:name];
    
    // 2.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    // 3.添加圆形裁剪区域，并正切于图片
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [path addClip];
    
    // 4.绘制图片
    [image drawAtPoint:CGPointZero];
    
    // 5.从当前上下文获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭当前上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
}

+ (UIImage *)imageWithClipImageName:(NSString *)name andBorderWidth:(CGFloat)border andBorderColor:(UIColor *)borderColor
{
    // 1.加载图片
    UIImage *image = [UIImage imageNamed:name];
    
    // 图片的宽高
    CGFloat imageWH = image.size.width;
    
    // 边框的宽
    //    CGFloat border = 2;
    
    // 背景大圆的宽高
    CGFloat ovalWH = imageWH + border * 2;
    
    // 2.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    
    // 3.画背景大圆
    UIBezierPath *backPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    [borderColor set];
    [backPath fill];
    
    // 4.绘制并裁剪图片
    UIBezierPath *imagePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    [imagePath addClip];
    [image drawAtPoint:CGPointMake(border, border)];
    
    // 5.获取当前图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭位图上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)imageWithCaputureView:(UIView *)view
{
    // 1.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    
    // 2.获取当前上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 3.把控件上的图层渲染到上下文,layer只能渲染
    [view.layer renderInContext:ref];
    
    // 4.从当前上下文得到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.关闭位图上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
