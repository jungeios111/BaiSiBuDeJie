//
//  ZKJNewController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/20.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJNewController.h"

@interface ZKJNewController ()

@end

@implementation ZKJNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" andHighLightImage:@"MainTagSubIconClick" andTarget:self andAction:@selector(btnClick)];
}

- (void)btnClick
{
    ZKJLogFunC;
}

@end
