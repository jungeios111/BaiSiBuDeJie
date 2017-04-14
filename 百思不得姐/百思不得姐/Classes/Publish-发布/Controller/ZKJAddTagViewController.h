//
//  ZKJAddTagViewController.h
//  百思不得姐
//
//  Created by ZKJ on 2017/4/13.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKJAddTagViewController : UIViewController

/** 获取tags的block */
@property (nonatomic, strong) void (^tagBlock)(NSArray *tags);
/** 所有的标签 */
@property (nonatomic, strong) NSArray *tags;

@end
