//
//  CHWebViewController.m
//  Financial
//
//  Created by Chausson on 16/3/9.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHWebViewController.h"
#import "CHWebViewProress.h"
#import "CHWebProgressView.h"

@interface CHWebViewController ()<CHWebViewDelegate>

@property (nonatomic ,strong) NSURLRequest *req;
@property (nonatomic ,assign) BOOL hiddenNavtionBar;
@end

@implementation CHWebViewController{
    BOOL _isFile;
    CHWebProgressView *_progressView;
    CHWebViewProress *_progressProxy;
}
- (instancetype)initWithURL:(NSString *)url
{
    if (self = [super init]) {
        _url = [NSURL URLWithString:url];
        
    }
    return self;
}
- (instancetype)initWithFile:(NSString *)url{
    if (self = [super init]) {
        _url = [NSURL fileURLWithPath:url];
        _isFile = YES;
    }
    return self;
}

- (NSURLRequest *)req{
    if (!_req) {
        _req = [NSURLRequest requestWithURL:self.url];
    }
    return _req;
}
#pragma mark Activity
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self layout];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_hiddenProgressView) {
        [_progressView removeFromSuperview];
    }
//    self.navigationController.navigationBarHidden = [self isNavigationHidden];
//    self.automaticallyAdjustsScrollViewInsets = ![self isNavigationHidden];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)initialize{
    CGRect rect = CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height);
    //#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    //#else
    //#endif
    if (self.useUIWebView) {
        _webView = [[CHWebView alloc]initWithUIWebView:rect];
    }else{
        _webView = [[CHWebView alloc]initWithFrame:rect];
        
    }
    [_webView loadRequest:self.req];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    _progressView = [[CHWebProgressView alloc]initWithFrame:CGRectMake(0, [self isNavigationHidden]?0:64, self.view.frame.size.width, 2)];
    if(_tintColor){
        _progressView.color = _tintColor;
    }
    if([self isNavigationHidden]){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:_progressView];
    
    
}
- (void)layout{
    [_webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    //layout 子view
    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    //把约束添加到父视图上
    NSArray *array = [NSArray arrayWithObjects:contraint1, contraint2, contraint3, contraint4, nil];
    [self.view addConstraints:array];
}
#pragma mark - WebViewDelegate

- (void)webView:(CHWebView *)webVie  updateProgress:(NSProgress *)progress{
    [_progressView setProgress:progress];
}
- (void)webView:(CHWebView *)webView withError:(NSError *)error{
    
}
- (void)webViewDidFinshLoad:(CHWebView *)webView{
    self.title = webView.title;
}
- (void)webViewDidStartLoad:(CHWebView *)webView{
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(completionHandler){
            completionHandler();
        }
    }]];
    if (self) {
        [self presentViewController:alert animated:YES completion:NULL];
    }
}

/**
 * @brief Register Invoke JavaScript observe
 */
- (NSObject *)registerJavaScriptHandler{
    return self;
}
- (NSArray <NSString *>*)registerJavascriptName{
    return nil;
}
#pragma mark Public

- (void)invokeJavaScript:(NSString *)function{
    [self.webView invokeJavaScript:function];
    
}

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler{
    [self.webView invokeJavaScript:function completionHandler:completionHandler];
}

#pragma makr Private
- (BOOL)isNavigationHidden{
    return !self.navigationController
            || !self.navigationController.navigationBar.isTranslucent
            || !self.navigationController.navigationBar;
}


-(void)dealloc{
    
}
@end
