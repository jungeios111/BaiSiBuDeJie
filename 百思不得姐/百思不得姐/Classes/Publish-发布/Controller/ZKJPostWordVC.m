//
//  ZKJPostWordVC.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/12.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJPostWordVC.h"
#import "ZKJTextView.h"

@interface ZKJPostWordVC ()

/** 文本输入控件 */
@property (nonatomic, strong) ZKJTextView *textView;

@end

@implementation ZKJPostWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
}

- (void)setupTextView
{
    ZKJTextView *textView = [[ZKJTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeHolder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)setupNav
{
    self.title = @"发段子";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    // 默认不能点击
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)cancelClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneClick
{
    
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
