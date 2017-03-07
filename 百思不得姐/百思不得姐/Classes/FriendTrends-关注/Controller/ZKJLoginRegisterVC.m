//
//  ZKJLoginRegisterVC.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/6.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJLoginRegisterVC.h"

@interface ZKJLoginRegisterVC ()
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;

@end

@implementation ZKJLoginRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(0, 1)];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor],
//                                 NSFontAttributeName : [UIFont systemFontOfSize:20]} range:NSMakeRange(1, 1)];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]} range:NSMakeRange(2, 1)];
//    _phoneTF.attributedPlaceholder = placeholder;
    
//    // 文字属性
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[NSForegroundColorAttributeName] = [UIColor greenColor];
//    
//    // NSAttributedString : 带有属性的文字(富文本技术)
//    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"手机号" attributes:dic];
//    _phoneTF.attributedPlaceholder = placeholder;
    
}

- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registAccountClick:(id)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
