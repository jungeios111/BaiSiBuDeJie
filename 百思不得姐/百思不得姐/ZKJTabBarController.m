//
//  ZKJTabBarController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/20.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJTabBarController.h"

@interface ZKJTabBarController ()

@end

@implementation ZKJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 正常状态
    NSMutableDictionary *norDic = [NSMutableDictionary dictionary];
    norDic[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    norDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    // 选中状态
    NSMutableDictionary *selDic = [NSMutableDictionary dictionary];
    selDic[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selDic[NSForegroundColorAttributeName] = [UIColor redColor];
    
    //添加自控制器
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.tabBarItem.title = @"精华";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    [vc1.tabBarItem setTitleTextAttributes:norDic forState:UIControlStateNormal];
    [vc1.tabBarItem setTitleTextAttributes:selDic forState:UIControlStateSelected];
    vc1.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.tabBarItem.title = @"最新";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    [vc2.tabBarItem setTitleTextAttributes:norDic forState:UIControlStateNormal];
    [vc2.tabBarItem setTitleTextAttributes:selDic forState:UIControlStateSelected];
    vc2.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.tabBarItem.title = @"关注";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    [vc3.tabBarItem setTitleTextAttributes:norDic forState:UIControlStateNormal];
    [vc3.tabBarItem setTitleTextAttributes:selDic forState:UIControlStateSelected];
    vc3.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.tabBarItem.title = @"我";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    [vc4.tabBarItem setTitleTextAttributes:norDic forState:UIControlStateNormal];
    [vc4.tabBarItem setTitleTextAttributes:selDic forState:UIControlStateSelected];
    vc4.view.backgroundColor = [UIColor darkGrayColor];
    [self addChildViewController:vc4];
}


@end
