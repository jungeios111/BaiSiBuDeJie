//
//  ZKJPublishVC.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/21.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJPublishVC.h"
#import "ZKJVerticalButton.h"
#import <POP.h>
#import "ZKJPostWordVC.h"
#import "ZKJNavigationController.h"

static CGFloat const ZKJAnimationDelay = 0.1;
static CGFloat const ZKJSpringFactor = 10;

@interface ZKJPublishVC ()

///** <#注释#> */
//@property(nonatomic,copy) void (^sendValue)();

@end

@implementation ZKJPublishVC

//- (void)test:(void (^)())sendValue
//{
//    void (^myblock)() = ^{
//        ZKJLogFunC;
//    };
//    myblock();
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    // 数据
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    
    // 6个按钮
    int maxCols = 3;
    CGFloat btnW = 72.0;
    CGFloat btnH = btnW + 30;
    CGFloat btnStartX = 20;
    CGFloat btnStartY = ZKJScreenHeight * 0.5 - btnH;
    CGFloat colsMargen = (ZKJScreenWidth - 2 * btnStartX - 3 * btnW) / 2;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    int row = 0;
    int col = 0;
    for (NSInteger i = 0; i < titles.count; i++) {
        row = i / maxCols;
        col = i % maxCols;
        btnX = btnStartX + (btnW + colsMargen) * col;
        btnY = btnStartY + btnH * row;
        CGFloat btnBeginY = btnH - ZKJScreenHeight;
        
        ZKJVerticalButton *btn = [ZKJVerticalButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        // 给按钮添加动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnBeginY, btnW, btnH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btnW, btnH)];
        animation.springBounciness = ZKJSpringFactor;
        animation.springSpeed = ZKJSpringFactor;
        animation.beginTime = CACurrentMediaTime() + i * ZKJAnimationDelay;
        [btn pop_addAnimation:animation forKey:nil];
    }
    
    // 添加标语
    UIImageView *slogan = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat centerX = ZKJScreenWidth * 0.5;
    CGFloat centerEndY = ZKJScreenHeight * 0.15;
    CGFloat centerStartY = centerEndY - ZKJScreenHeight;
    slogan.center = CGPointMake(centerX, centerStartY);
    [self.view addSubview:slogan];
    
    // 给标语添加动画
    POPSpringAnimation *sloganAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    sloganAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerStartY)];
    sloganAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    sloganAnim.springBounciness = ZKJSpringFactor;
    sloganAnim.springSpeed = ZKJSpringFactor;
    sloganAnim.beginTime = CACurrentMediaTime() + images.count * ZKJAnimationDelay;
    [sloganAnim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        // 标语动画执行完毕, 恢复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    [slogan pop_addAnimation:sloganAnim forKey:nil];
}

- (void)btnClick:(UIButton *)btn
{
    [self animationOutCompletionBlock:^{
        if (btn.tag == 2) {
            ZKJPostWordVC *postVC = [[ZKJPostWordVC alloc] init];
            ZKJNavigationController *nav = [[ZKJNavigationController alloc] initWithRootViewController:postVC];
            
            // 这里不能使用self来弹出其他控制器, 因为self执行了dismiss操作
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root presentViewController:nav animated:YES completion:nil];
        }
    }];
}

- (IBAction)cancelClick
{
    [self animationOutCompletionBlock:nil];
}

/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
- (void)animationOutCompletionBlock:(void (^)())completionBlock
{
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    int beginIndex = 2;
    for (int i = beginIndex; i < self.view.subviews.count; i++) {
        UIView *subView = self.view.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subView.centerY + ZKJScreenHeight;
        
        // 动画的执行节奏(一开始很慢, 后面很快)
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * ZKJAnimationDelay;
        [subView pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
                // 执行传进来的completionBlock参数
                if (completionBlock) {
                    completionBlock();
                }
                
//                // 装B写法
//                !completionBlock ? :completionBlock();
            }];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self animationOutCompletionBlock:nil];
}

/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */

@end
