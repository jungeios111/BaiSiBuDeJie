//
//  UIBarButtonItem+Extension.h
//  百思不得姐
//
//  Created by ZKJ on 2017/2/21.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image andHighLightImage:(NSString *)highLightImage andTarget:(id)target andAction:(SEL)action;

@end
