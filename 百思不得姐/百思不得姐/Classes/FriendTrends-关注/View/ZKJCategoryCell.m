//
//  ZKJCategoryCell.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/23.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJCategoryCell.h"
#import "ZKJCategoryModel.h"

@interface ZKJCategoryCell ()
@property (strong, nonatomic) IBOutlet UIView *selectView;

@end

@implementation ZKJCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.backgroundColor = ZKJRGBColor(244, 244, 244);
    self.selectView.backgroundColor = ZKJRGBColor(219, 21, 26);
    
    // 当cell的selection为None时, 即使cell被选中了, 内部的子控件也不会进入高亮状态
    // self.textLabel.highlightedTextColor = XMGRGBColor(219, 21, 26);
}

- (void)setCategoryModel:(ZKJCategoryModel *)categoryModel
{
    _categoryModel = categoryModel;
    self.textLabel.text = categoryModel.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

/**
 * 可以在这个方法中监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectView.hidden = !selected;
    self.backgroundColor = selected ? ZKJRGBColor(244, 244, 244) : [UIColor clearColor];
    self.textLabel.textColor = selected ? self.selectView.backgroundColor : ZKJRGBColor(78, 78, 78);
}

@end
