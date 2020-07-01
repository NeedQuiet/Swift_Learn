//
//  ViewController.m
//  test
//
//  Created by 许一宁 on 2020/6/30.
//  Copyright © 2020 许一宁. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "JavaScriptCore/JSContext.h"

@interface ViewController ()<WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate>{
    WKWebView * _webView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width
                                                           , [UIScreen mainScreen].bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height) configuration:configuration];
    
    [self.view addSubview:_webView];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://x.eqxiu.com/s/eTgzTLP6?bt=yxy"]];
    [request setTimeoutInterval:15];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [_webView loadRequest:request];
    
    UIButton * btton = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
    [btton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    btton.backgroundColor = [UIColor redColor];
    [self.view addSubview:btton];
}

- (void)next{
    NSString * textJS = [NSString stringWithFormat:@"goToNextPage()"];
    NSString *allHtml = @"document.documentElement.innerHTML";
    [_webView evaluateJavaScript:allHtml completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.description);
        }else{
            NSLog(@"%@", data);
        }
    }];
}

#pragma mark -- WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}

#pragma markt WKWebViewDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{

}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}


@end
