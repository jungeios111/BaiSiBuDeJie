//
//  ZKJTagTextField.h
//  百思不得姐
//
//  Created by ZKJ on 2017/4/14.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKJTagTextField : UITextField

/** 按了删除键后的回调 */
@property (nonatomic, strong) void (^deleteTextBlock)();

@end
