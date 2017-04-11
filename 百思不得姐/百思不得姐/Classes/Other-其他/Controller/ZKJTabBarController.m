//
//  ZKJTabBarController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/2/20.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJTabBarController.h"
#import "ZKJEssenceController.h"
#import "ZKJNewController.h"
#import "ZKJFriendTrendsController.h"
#import "ZKJMeViewController.h"
#import "ZKJTabBar.h"
#import "ZKJNavigationController.h"

@interface ZKJTabBarController ()

@end

@implementation ZKJTabBarController

/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    // 正常状态
    NSMutableDictionary *norDic = [NSMutableDictionary dictionary];
    norDic[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    norDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    // 选中状态
    NSMutableDictionary *selDic = [NSMutableDictionary dictionary];
    selDic[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selDic[NSForegroundColorAttributeName] = [UIColor redColor];
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    // - (void)setTitleTextAttributes:(nullable NSDictionary<NSString *,id> *)attributes forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:norDic forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selDic forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setUpChildVc:[[ZKJEssenceController alloc] init] andTitle:@"精华" andNorImage:@"tabBar_essence_icon" andSelectImage:@"tabBar_essence_click_icon"];
    [self setUpChildVc:[[ZKJNewController alloc] init] andTitle:@"最新" andNorImage:@"tabBar_new_icon" andSelectImage:@"tabBar_new_click_icon"];
    [self setUpChildVc:[[ZKJFriendTrendsController alloc] init] andTitle:@"关注" andNorImage:@"tabBar_friendTrends_icon" andSelectImage:@"tabBar_friendTrends_click_icon"];
    [self setUpChildVc:[[ZKJMeViewController alloc] initWithStyle:UITableViewStyleGrouped] andTitle:@"我" andNorImage:@"tabBar_me_icon" andSelectImage:@"tabBar_me_click_icon"];
    
    // 更换tabBar
    //@property(nonatomic,readonly) UITabBar *tabBar NS_AVAILABLE_IOS(3_0),tabBar属性是readonly,不能通过alloc来赋值,通过kvc来赋值.
//    self.tabBar = [[ZKJTabBar alloc] init];
    [self setValue:[[ZKJTabBar alloc] init] forKeyPath:@"tabBar"];
}

/**
 * 初始化子控制器
 */
- (void)setUpChildVc:(UIViewController *)vc andTitle:(NSString *)title andNorImage:(NSString *)norImage andSelectImage:(NSString *)selImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:norImage];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    ZKJNavigationController *nav = [[ZKJNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
