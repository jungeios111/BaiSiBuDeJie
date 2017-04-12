//
//  ZKJTextView.h
//  百思不得姐
//
//  Created by ZKJ on 2017/4/12.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKJTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeHolder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeHolderColor;

@end
