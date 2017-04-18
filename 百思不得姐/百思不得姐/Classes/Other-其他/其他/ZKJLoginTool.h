//
//  ZKJLoginTool.h
//  百思不得姐
//
//  Created by ZKJ on 2017/4/17.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKJLoginTool : NSObject

+ (void)setUid:(NSString *)uid;

+ (NSString *)getUid;
+ (NSString *)getUid:(BOOL)isShowLoginVC;

@end
