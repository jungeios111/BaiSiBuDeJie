//
//  ZKJAddTagViewController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/13.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJAddTagViewController.h"
#import "ZKJTagButton.h"

@interface ZKJAddTagViewController ()

/** 内容view */
@property (nonatomic, weak) UIView *contentView;
/** 文本输入框 */
@property (nonatomic, weak) UITextField *textField;
/** 添加按钮 */
@property (nonatomic, weak) UIButton *addBtn;
/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtonArray;

@end

@implementation ZKJAddTagViewController

- (NSMutableArray *)tagButtonArray
{
    if (!_tagButtonArray) {
        _tagButtonArray = [NSMutableArray array];
    }
    return _tagButtonArray;
}

- (UIButton *)addBtn
{
    if (!_addBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.width = self.contentView.width;
        btn.height = 35;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, ZKJTagMargin, 0, ZKJTagMargin);
        // 让按钮内部的文字和图片都左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.backgroundColor = ZKJTagButtonBGColor;
        [self.contentView addSubview:btn];
        _addBtn = btn;
    }
    return _addBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupContentView];
    
    [self setupTextField];
}

- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.width = ZKJScreenWidth;
    textField.height = 25;
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    // 设置了占位文字内容以后, 才能设置占位文字的颜色
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = ZKJTagMargin;
    contentView.y = ZKJTagMargin + 64;
    contentView.width = ZKJScreenWidth - 2 * contentView.x;
    contentView.height = ZKJScreenHeight;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupBasic
{
    self.title = @"添加标签";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
}

/**
 * 监听文字改变
 */
- (void)textDidChange
{
    if (self.textField.hasText) {
        // 有文字 显示"添加标签"的按钮
        self.addBtn.hidden = NO;
        self.addBtn.y = CGRectGetMaxY(self.textField.frame) + ZKJTagMargin;
        [self.addBtn setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
    } else {
        // 没有文字 隐藏"添加标签"的按钮
        self.addBtn.hidden = YES;
    }
    
    // 更新标签和文本框的frame
    [self updateTagButtonsFrame];
}

/**
 * 监听"添加标签"按钮点击
 */
- (void)addBtnClick
{
    // 添加一个"标签按钮"
    ZKJTagButton *tagBtn = [ZKJTagButton buttonWithType:UIButtonTypeCustom];
    [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagBtn setTitle:self.textField.text forState:UIControlStateNormal];
    tagBtn.height = self.textField.height;
    [self.contentView addSubview:tagBtn];
    [self.tagButtonArray addObject:tagBtn];
    
    // 更新标签按钮的frame
    [self updateTagButtonsFrame];
    
    // 清空textField文字
    self.textField.text = nil;
    self.addBtn.hidden = YES;
}

/**
 * 专门用来更新标签按钮的frame
 */
- (void)updateTagButtonsFrame
{
    // 更新标签按钮的frame
    for (NSInteger i = 0; i < self.tagButtonArray.count; i++) {
        ZKJTagButton *button = self.tagButtonArray[i];
        
        if (i == 0) {
            // 最前面的标签按钮
            button.x = 0;
            button.y = 0;
        } else {
            // 其他标签按钮
            ZKJTagButton *lastButton = self.tagButtonArray[i-1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + ZKJTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= button.width) {
                // 按钮显示在当前行
                button.x = leftWidth;
                button.y = lastButton.y;
            } else {
                // 按钮显示在下一行
                button.x = 0;
                button.y = CGRectGetMaxY(lastButton.frame) + ZKJTagMargin;
            }
        }
        
        // 最后一个标签按钮
        ZKJTagButton *lastTagBtn = [self.tagButtonArray lastObject];
        CGFloat leftWidth = CGRectGetMaxX(lastTagBtn.frame) + ZKJTagMargin;
        CGFloat rightWidth = self.contentView.width - leftWidth;
        
        // 更新textField的frame
        if (rightWidth >= [self textFieldWidth]) {
            self.textField.x = leftWidth;
            self.textField.y = lastTagBtn.y;
        } else {
            self.textField.x = 0;
            self.textField.y = CGRectGetMaxY(lastTagBtn.frame) + ZKJTagMargin;
        }
    }
}

/**
 * textField的文字宽度
 */
- (CGFloat)textFieldWidth
{
    CGFloat width = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, width);
}

/**
 * 标签按钮的点击
 */
- (void)tagBtnClick:(ZKJTagButton *)button
{
    [button removeFromSuperview];
    [self.tagButtonArray removeObject:button];
    
    // 重新更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonsFrame];
    }];
}

- (void)cancelClick
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneClick
{
    
}

@end
