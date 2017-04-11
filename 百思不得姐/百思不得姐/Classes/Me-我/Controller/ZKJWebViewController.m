//
//  ZKJWebViewController.m
//  百思不得姐
//
//  Created by ZKJ on 2017/4/11.
//  Copyright © 2017年 ZKJ. All rights reserved.
//

#import "ZKJWebViewController.h"
#import <NJKWebViewProgress.h>

@interface ZKJWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 进度代理对象 */
@property (nonatomic, strong) NJKWebViewProgress *progress;

@end

@implementation ZKJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress){
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (IBAction)goBack:(UIBarButtonItem *)sender
{
    [self.webView goBack];
}

- (IBAction)goForward:(UIBarButtonItem *)sender
{
    [self.webView goForward];
}

- (IBAction)refresh:(UIBarButtonItem *)sender
{
    [self.webView reload];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

@end
