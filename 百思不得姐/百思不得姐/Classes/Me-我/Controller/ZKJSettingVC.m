//
//  ZKJSettingVC.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/17.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJSettingVC.h"
#import <SDImageCache.h>

@interface ZKJSettingVC ()<UIAlertViewDelegate>

@end

@implementation ZKJSettingVC

static NSString * const cellName = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.tableView.backgroundColor = ZKJGlobalBGColor;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellName];
    
//    ZKJLog(@"%@", NSTemporaryDirectory());
//    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    ZKJLog(@"%@", cache);
//    /Users/songzh/Desktop/百思不得姐.xcappdata/AppData/Library/Caches/default/com.hackemist.SDWebImageCache.default
//    [self getSize];
//    [self getFilePath];
}

- (void)getFilePath
{
    NSInteger totalSize = [SDImageCache sharedImageCache].getSize;
    ZKJLog(@"%zd", totalSize);
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *cachePath = [cache stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    // 获得文件夹内部的所有内容
//    NSArray *array = [manager contentsOfDirectoryAtPath:cachePath error:nil];
    NSArray *array = [manager subpathsAtPath:cachePath];
    ZKJLog(@"array:%@", array);
}




// 获得沙盒缓存
- (NSInteger)getSize
{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *cacheFile = [cache stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    ZKJLog(@"cacheFile:%@", cacheFile);
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:cacheFile];
    NSInteger totalSize = 0;
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cacheFile stringByAppendingPathComponent:fileName];
        
        // 判断文件的类型：文件\文件夹
        BOOL directory = NO;
        [manager fileExistsAtPath:filePath isDirectory:&directory];
        if (directory) continue;
        
        NSDictionary *atts = [manager attributesOfItemAtPath:filePath error:nil];
        ZKJLog(@"%@", atts);
        if ([atts[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        totalSize += [atts[NSFileSize] integerValue];
    }
    
    ZKJLog(@"totalSize:%zd", totalSize);
    return totalSize;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    CGFloat size = [SDImageCache sharedImageCache].getSize / 1000.0 / 1000;
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存（已使用%.2fM）", size];
    
//    CGFloat size = [self getSize] / 1000.0 / 1000;
//    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存（已使用%.2fM）", size];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确认清除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[SDImageCache sharedImageCache] clearDisk];
        [self.tableView reloadData];
    }
}

@end
