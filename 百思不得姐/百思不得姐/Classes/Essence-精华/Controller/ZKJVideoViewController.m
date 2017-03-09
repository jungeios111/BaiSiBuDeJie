//
//  ZKJVideoViewController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/3/9.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJVideoViewController.h"

@interface ZKJVideoViewController ()

@end

@implementation ZKJVideoViewController

static NSString *cellName = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.backgroundColor = [UIColor grayColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ ------- %zd", [self class], indexPath.row];
    return cell;
}

@end
