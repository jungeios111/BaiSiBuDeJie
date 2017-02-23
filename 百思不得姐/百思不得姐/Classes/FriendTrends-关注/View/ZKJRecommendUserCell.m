//
//  ZKJRecommendUserCell.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/23.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJRecommendUserCell.h"
#import "ZKJUserModel.h"
#import <UIImageView+WebCache.h>

@interface ZKJRecommendUserCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nikeNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *followCountLabel;

@end

@implementation ZKJRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ZKJRGBColor(244, 244, 244);
}

- (void)setUserModel:(ZKJUserModel *)userModel
{
    _userModel = userModel;
    self.nikeNameLabel.text = userModel.screen_name;
    self.followCountLabel.text = [NSString stringWithFormat:@"%@人关注", userModel.fans_count];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
//    self.headImageView.image = [UIImage imageWithClipImage:self.headImageView.image];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
