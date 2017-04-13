//
//  ZKJPostWordVC.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/12.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJPostWordVC.h"
#import "ZKJTextView.h"
#import "ZKJAddTagToolbar.h"

@interface ZKJPostWordVC ()<UITextViewDelegate>

/** 文本输入控件 */
@property (nonatomic, weak) ZKJTextView *textView;
/** toolbar */
@property (nonatomic, weak) ZKJAddTagToolbar *toolBar;

@end

@implementation ZKJPostWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolBar];
}

- (void)setupToolBar
{
    ZKJAddTagToolbar *toolBar = [ZKJAddTagToolbar viewFromXib];
    toolBar.width = ZKJScreenWidth;
    toolBar.y = ZKJScreenHeight - toolBar.height;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
    [ZKJDefaultCenter addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 * 监听键盘的弹出和隐藏
 */
- (void)keyboardFrameWillChange:(NSNotification *)note
{
    // 键盘最终的frame
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 动画时间
    CGFloat time = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:time animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, rect.origin.y - ZKJScreenHeight);
    }];
}

- (void)setupTextView
{
    ZKJTextView *textView = [[ZKJTextView alloc] init];
    textView.placeHolder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)setupNav
{
    self.title = @"发段子";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    // 默认不能点击
    self.navigationItem.rightBarButtonItem.enabled = NO;
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)cancelClick
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneClick
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/*
 UITextField *textField默认的情况
 1.只能显示一行文字
 2.有占位文字
 
 UITextView *textView默认的情况
 2.能显示任意行文字
 2.没有占位文字
 
 文本输入控件,最终希望拥有的功能
 1.能显示任意行文字
 2.有占位文字
 
 最终的方案:
 1.继承自UITextView
 2.在UITextView能显示任意行文字的基础上,增加"有占位文字"的功能
 */

@end
