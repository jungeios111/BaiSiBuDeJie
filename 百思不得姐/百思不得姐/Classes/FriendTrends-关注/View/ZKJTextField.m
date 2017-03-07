//
//  ZKJTextField.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/7.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJTextField.h"
#import <objc/runtime.h>

static NSString * const ZkjPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation ZKJTextField

/**
 * 1.重绘placeholder,改变placeholder的颜色等
 */
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 5, self.width, 20) withAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
//                                                                                   NSFontAttributeName : self.font}];
//}

+ (void)initialize
{
    [super initialize];
    [self getIvars];
}

+ (void)getIvars
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        ZKJLog(@"%s  ---  %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    
    free(ivars);
}

- (void)setUp
{
    // 1
//    UILabel *label = [self valueForKeyPath:@"_placeholderLabel"];
//    label.textColor = [UIColor whiteColor];
    // 2
//    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:ZkjPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:ZkjPlaceholderColorKeyPath];
    return [super resignFirstResponder];
}


@end
