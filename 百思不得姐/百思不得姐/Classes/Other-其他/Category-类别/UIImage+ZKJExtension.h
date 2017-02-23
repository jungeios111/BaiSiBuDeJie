//
//  UIImage+ZKJExtension.h
//  百思不得姐
//
//  Created by ZKJ on 2017/2/23.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZKJExtension)

/** 不带光环的图片裁剪 */
+ (UIImage *)imageWithClipImageName:(NSString *)name;
+ (UIImage *)imageWithClipImage:(UIImage *)image;

/** 带光环的图片裁剪 */
+ (UIImage *)imageWithClipImageName:(NSString *)name andBorderWidth:(CGFloat)border andBorderColor:(UIColor *)borderColor;

/** 屏幕截屏 */
+ (UIImage *)imageWithCaputureView:(UIView *)view;

@end
