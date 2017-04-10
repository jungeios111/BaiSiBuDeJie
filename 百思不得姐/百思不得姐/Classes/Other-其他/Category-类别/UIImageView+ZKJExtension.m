//
//  UIImageView+ZKJExtension.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/10.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "UIImageView+ZKJExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (ZKJExtension)

- (void)setHead_image:(NSString *)url
{
    UIImage *placeHolderImg = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolderImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeHolderImg;
    }];
}

@end
