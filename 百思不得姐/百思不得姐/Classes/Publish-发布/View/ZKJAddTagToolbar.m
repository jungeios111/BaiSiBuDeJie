//
//  ZKJAddTagToolbar.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/12.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJAddTagToolbar.h"
#import "ZKJAddTagViewController.h"

@interface ZKJAddTagToolbar ()

/** 顶部的view */
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 添加按钮 */
@property (nonatomic, strong) UIButton *button;
/** 存放所有标签label的数组 */
@property (nonatomic, strong) NSMutableArray *tagLabels;

@end

@implementation ZKJAddTagToolbar

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 添加一个加号按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    btn.size = [UIImage imageNamed:@"tag_add_icon"].size;
//    btn.size = [btn imageForState:UIControlStateNormal].size;
    btn.size = btn.currentImage.size;
    btn.x = ZKJTagMargin;
    [self addSubview:btn];
    self.button = btn;
    
    // 默认就拥有2个标签
    [self createTagLabel:@[@"吐槽", @"糗事"]];
}

- (void)btnClick
{
    ZKJAddTagViewController *tagVC = [[ZKJAddTagViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    [tagVC setTagBlock:^(NSArray *tags){
        [weakSelf createTagLabel:tags];
    }];
    tagVC.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:tagVC animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.tagLabels.count; i++) {
        UILabel *label = self.tagLabels[i];
        
        // 设置位置
        if (i == 0) {
            // 最前面的标签按钮
            label.x = 0;
            label.y = 0;
        } else {
            // 其他标签按钮
            UILabel *lastLabel = self.tagLabels[i-1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + ZKJTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= label.width) {
                // 按钮显示在当前行
                label.x = leftWidth;
                label.y = lastLabel.y;
            } else {
                // 按钮显示在下一行
                label.x = 0;
                label.y = CGRectGetMaxY(lastLabel.frame) + ZKJTagMargin;
            }
        }
        
        // 最后一个标签按钮
        UILabel *lastLabel = [self.tagLabels lastObject];
        CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + ZKJTopicCellMargin;
        CGFloat rightWidth = self.topView.width - leftWidth;
        
        // 更新textField的frame
        if (rightWidth >= self.button.width) {
            self.button.x = leftWidth;
            self.button.y = lastLabel.y;
        } else {
            self.button.x = 0;
            self.button.y = CGRectGetMaxY(lastLabel.frame) + ZKJTagMargin;
        }
    }
    
    // 整体的高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.button.frame) + 45;
//    ZKJLog(@"oldH:%f    self.height:%f", oldH, self.height);
    self.y -= self.height - oldH;
}

/**
 * 创建标签
 */
- (void)createTagLabel:(NSArray *)array
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i < array.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        [self.tagLabels addObject:label];
        label.backgroundColor = ZKJTagButtonBGColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = array[i];
        label.font = ZKJTagFont;
        // 应该要先设置文字和字体后，再进行计算
        [label sizeToFit];
        label.width += 2 * ZKJTagMargin;
        label.height = ZKJTagH;
        label.textColor = [UIColor whiteColor];
        [self.topView addSubview:label];
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
}

// a modal 出 b
// [a presentViewController:b animated:YES completion:nil];
// a.presentedViewController -> b
// b.presentingViewController -> a

@end
