//
//  ZKJAddTagViewController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/13.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJAddTagViewController.h"
#import "ZKJTagButton.h"
#import "ZKJTagTextField.h"
#import <SVProgressHUD.h>

@interface ZKJAddTagViewController ()<UITextFieldDelegate>

/** 内容view */
@property (nonatomic, weak) UIView *contentView;
/** 文本输入框 */
@property (nonatomic, weak) ZKJTagTextField *textField;
/** 添加按钮 */
@property (nonatomic, weak) UIButton *addBtn;
/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtonArray;

@end

@implementation ZKJAddTagViewController

#pragma mark - 懒加载
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
        btn.height = 35;
        btn.hidden = YES;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = ZKJTagFont;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, ZKJTagMargin, 0, ZKJTagMargin);
        // 让按钮内部的文字和图片都左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.backgroundColor = ZKJTagButtonBGColor;
        [self.contentView addSubview:btn];
        _addBtn = btn;
    }
    return _addBtn;
}

- (UIView *)contentView
{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (ZKJTagTextField *)textField
{
    if (!_textField) {
        __weak typeof(self) weakSelf = self;
        ZKJTagTextField *textField = [[ZKJTagTextField alloc] init];
        [textField setDeleteTextBlock:^{
            if (weakSelf.textField.hasText) return ;
            [weakSelf tagBtnClick:[weakSelf.tagButtonArray lastObject]];
        }];
        textField.delegate = self;
        [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        [textField becomeFirstResponder];
        [self.contentView addSubview:textField];
        _textField = textField;
    }
    return _textField;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
}

- (void)setupTags
{
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self addBtnClick];
    }
    self.tags = nil;
}

- (void)setupBasic
{
    self.title = @"添加标签";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
}

#pragma mark - 监听文字改变
/**
 * 监听文字改变
 */
- (void)textDidChange
{
    // 更新文本框的frame
    [self updateTextFieldFrame];
    
    if (self.textField.hasText) {
        // 有文字 显示"添加标签"的按钮
        self.addBtn.hidden = NO;
        self.addBtn.y = CGRectGetMaxY(self.textField.frame) + ZKJTagMargin;
        [self.addBtn setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        
        // 获得最后一个字符
        NSString *text = self.textField.text;
        NSInteger length = text.length;
        NSString *lastLetter = [text substringFromIndex:length - 1];
        if ([lastLetter isEqualToString:@","] || [lastLetter isEqualToString:@"，"]) {
            // 去除逗号
            self.textField.text = [text substringToIndex:length - 1];
            [self addBtnClick];
        }
    } else {
        // 没有文字 隐藏"添加标签"的按钮
        self.addBtn.hidden = YES;
    }
}

#pragma mark - 监听添加标签按钮点击
/**
 * 监听"添加标签"按钮点击
 */
- (void)addBtnClick
{
    if (self.tagButtonArray.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    // 添加一个"标签按钮"
    ZKJTagButton *tagBtn = [ZKJTagButton buttonWithType:UIButtonTypeCustom];
    [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagBtn setTitle:self.textField.text forState:UIControlStateNormal];
    [self.contentView addSubview:tagBtn];
    [self.tagButtonArray addObject:tagBtn];
    
    // 清空textField文字
    self.textField.text = nil;
    self.addBtn.hidden = YES;
    
    // 更新标签按钮的frame
    [self updateTagButtonsFrame];
    
    // 更新输入框的frame
    [self updateTextFieldFrame];
}

#pragma mark - 监听标签按钮的点击
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
        [self updateTextFieldFrame];
    }];
}

#pragma mark - 用来更新标签按钮的frame
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
    }
}

#pragma mark - 更新textField的frame
/**
 * 更新textField的frame
 */
- (void)updateTextFieldFrame
{
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
    
    // 更新“添加标签”的frame
    self.addBtn.y = CGRectGetMaxY(self.textField.frame) + ZKJTagMargin;
}

/**
 * textField的文字宽度
 */
- (CGFloat)textFieldWidth
{
    CGFloat width = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, width);
}

#pragma mark - <UITextFieldDelegate>
/**
 * 监听键盘最右下角按钮的点击（return key， 比如“换行”、“完成”等等）
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.hasText) {
        [self addBtnClick];
    }
    return YES;
}

- (void)cancelClick
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneClick
{
    // 传递数据给上一个控制器
//    NSMutableArray *tags = [NSMutableArray array];
//    for (ZKJTagButton *button in self.tagButtonArray) {
//        [tags addObject:button.currentTitle];
//    }
//    ZKJLog(@"%@", tags);
    
    // 传递tags给这个block
    NSArray *tags = [self.tagButtonArray valueForKeyPath:@"currentTitle"];
    !self.tagBlock ? : self.tagBlock(tags);
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 布局控制器view的子控件
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentView.x = ZKJTagMargin;
    self.contentView.y = ZKJTagMargin + 64;
    self.contentView.width = ZKJScreenWidth - 2 * self.contentView.x;
    self.contentView.height = ZKJScreenHeight;
    self.textField.width = self.contentView.width;
    self.addBtn.width = self.contentView.width;
    [self setupTags];
}

@end
