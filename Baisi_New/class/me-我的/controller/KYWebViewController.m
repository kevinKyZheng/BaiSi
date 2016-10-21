//
//  KYWebViewController.m
//  Baisi_New
//
//  Created by 郑开元 on 16/9/18.
//  Copyright © 2016年 郑开元. All rights reserved.
//

#import "KYWebViewController.h"
#import "KYSquare.h"

@interface KYWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backward;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;


@end

@implementation KYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.square.name;
    self.webView.backgroundColor = KYBgColor;
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.square.url]]];
}
- (IBAction)forward:(id)sender {
    [self.webView goForward];
}
- (IBAction)back:(id)sender {
    [self.webView goBack];
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}
#pragma mark
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.backward.enabled = webView.canGoBack;
    self.forward.enabled = webView.canGoForward;
}

@end
