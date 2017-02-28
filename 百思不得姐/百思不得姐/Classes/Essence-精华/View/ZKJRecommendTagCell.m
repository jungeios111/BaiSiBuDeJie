//
//  ZKJRecommendTagCell.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/28.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJRecommendTagCell.h"
#import "ZKJRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface ZKJRecommendTagCell ()

@property (strong, nonatomic) IBOutlet UIImageView *listImageView;
@property (strong, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation ZKJRecommendTagCell

- (void)setModel:(ZKJRecommendTag *)model
{
    _model = model;
    [self.listImageView sd_setImageWithURL:[NSURL URLWithString:model.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = model.theme_name;
    
    NSString *subNumber = nil;
    if (model.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", model.sub_number];
    } else {
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", model.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5.0;
    frame.size.width -= 2 *frame.origin.x;
    frame.size.height -= 1.0;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
