//
//  ZKJTagButton.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/13.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJTagButton.h"

@implementation ZKJTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = ZKJTagButtonBGColor;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3 * ZKJTagMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = ZKJTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + ZKJTagMargin;
}

@end
