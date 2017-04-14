//
//  ZKJTagTextField.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/14.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJTagTextField.h"

@implementation ZKJTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.height = ZKJTagH;
        self.placeholder = @"多个标签用逗号或者换行隔开";
        // 设置了占位文字内容以后, 才能设置占位文字的颜色
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    return self;
}

// 也能在这个方法中监听键盘的输入，比如输入“换行”
//- (void)insertText:(NSString *)text
//{
//    [super insertText:text];
//
//    XMGLog(@"%d", [text isEqualToString:@"\n"]);
//}

- (void)deleteBackward
{
    !self.deleteTextBlock ? : self.deleteTextBlock();
    [super deleteBackward];
}


@end
