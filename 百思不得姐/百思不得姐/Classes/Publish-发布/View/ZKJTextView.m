//
//  ZKJTextView.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/12.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJTextView.h"

@interface ZKJTextView ()

/** 占位label */
@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation ZKJTextView

- (UILabel *)placeHolderLabel
{
    if (!_placeHolderLabel) {
        // 添加一个用来显示占位文字的label
        UILabel *label = [[UILabel alloc] init];
        label.x = 4;
        label.y = 7;
        label.numberOfLines = 0;
        [self addSubview:label];
        _placeHolderLabel = label;
    }
    return _placeHolderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        // 默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 默认的占位文字颜色
        self.placeHolderColor = [UIColor lightGrayColor];
        
        // 监听文字改变
        [ZKJDefaultCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [ZKJDefaultCenter removeObserver:self];
}

/** 
 * 监听文字的改变
 */
- (void)textDidChange
{
    // 只要有文字, 就隐藏占位文字label
    self.placeHolderLabel.hidden = self.hasText;
}

/**
 * 更新占位文字的尺寸
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeHolderLabel.width = ZKJScreenWidth - 2 * self.placeHolderLabel.x;
    [self.placeHolderLabel sizeToFit];
}

#pragma mark - 重写setter方法
- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = [placeHolder copy];
    self.placeHolderLabel.text = placeHolder;
    [self setNeedsLayout];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    self.placeHolderLabel.textColor = placeHolderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textDidChange];
}

@end

/**
 * setNeedsDisplay方法 : 会在恰当的时刻自动调用drawRect:方法
 * setNeedsLayout方法 : 会在恰当的时刻调用layoutSubviews方法
 */

/**
 // 利用drawRect实现占位文字
 #import "ZKJTextView.h"
 
 @implementation ZKJTextView
 
 - (instancetype)initWithFrame:(CGRect)frame
 {
 if (self = [super initWithFrame:frame]) {
 // 垂直方向上永远有弹簧效果
 self.alwaysBounceVertical = YES;
 
 // 默认字体
 self.font = [UIFont systemFontOfSize:15];
 
 // 默认的占位文字颜色
 self.placeHolderColor = [UIColor lightGrayColor];
 
 // 监听文字改变
 [ZKJDefaultCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
 }
 return self;
 }
 
 - (void)dealloc
 {
 [ZKJDefaultCenter removeObserver:self];
 }
 

 * 监听文字的改变
 
- (void)textDidChange
{
    [self setNeedsDisplay];
}


 * 绘制占位文字(每次drawRect:之前, 会自动清除掉之前绘制的内容)
 
- (void)drawRect:(CGRect)rect
{
    // 如果有文字, 直接返回, 不绘制占位文字
    // if (self.text.length || self.attributedText.length) return;
    if (self.hasText) return;
    
    // 处理rect
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width -= 2 * rect.origin.x;
    
    // 文字属性
    NSMutableDictionary *attsDic = [NSMutableDictionary dictionary];
    attsDic[NSFontAttributeName] = self.font;
    attsDic[NSForegroundColorAttributeName] = self.placeHolderColor;
    [self.placeHolder drawInRect:rect withAttributes:attsDic];
}
 */

