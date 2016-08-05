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

@interface CHWebViewController ()<UIWebViewDelegate,CHWebViewProgressDelegate ,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) JSContext *context;
@property (nonatomic ,strong) NSURLRequest *req;
@property (nonatomic ,assign) BOOL hiddenNavtionBar;
@end

@implementation CHWebViewController{
    BOOL _isFile;
    WKWebView *_wkWebView;
    UIWebView *_uiWebView;
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
- (instancetype)initWithURL:(NSString *)url withOutNavtionBar:(BOOL)hidden{
    if (self = [super init]) {
        _url = [NSURL URLWithString:url];
        _hiddenNavtionBar = hidden ;
    }
    return self;
}

- (instancetype)initWithFile:(NSString *)url withOutNavtionBar:(BOOL)hidden{
    if (self = [super init]) {
        _url = [NSURL fileURLWithPath:url];
        _isFile = YES;
        _hiddenNavtionBar = hidden;
    }
    return self;
}
- (void)initialize{
    CGRect rect = CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height);
//#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
//#else
//#endif
    if (self.useUIWebView) {
        _uiWebView = [[UIWebView alloc]initWithFrame:rect];
        if (![self isNavigationHidden]) {
            _progressProxy = [[CHWebViewProress alloc]init];
            _progressProxy.webViewProxyDelegate = self;
            _progressProxy.progressDelegate = self;
            _uiWebView.delegate = _progressProxy;
        }else{
            _uiWebView.delegate = self;
        }
            [self.view addSubview:_uiWebView];
            [_uiWebView loadRequest:self.req];
    }else{
        WKWebViewConfiguration *configuretion = [[WKWebViewConfiguration alloc] init];
        configuretion.preferences = [[WKPreferences alloc]init];
        configuretion.preferences.minimumFontSize = 10;
        configuretion.preferences.javaScriptEnabled = true;
        configuretion.processPool = [[WKProcessPool alloc]init];
        // 默认是不能通过JS自动打开窗口的，必须通过用户交互才能打开
        configuretion.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        _wkWebView = [[WKWebView alloc] initWithFrame:rect configuration:configuretion];
        _wkWebView.allowsBackForwardNavigationGestures =YES;
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        [self registerForKVO];
        [self.view addSubview:_wkWebView];
        [_wkWebView loadRequest:self.req];
    }
    _wkWebView.backgroundColor = _uiWebView.backgroundColor = [UIColor whiteColor];


    _progressView = [[CHWebProgressView alloc]initWithFrame:CGRectMake(0, [self isNavigationHidden]?1:65, self.view.frame.size.width, 2)];
    if(_tintColor){
        _progressView.tintColor = _tintColor;
    }
    if([self isNavigationHidden]){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:_progressView];


}
- (NSURLRequest *)req{
    if (!_req) {
        _req = [NSURLRequest requestWithURL:self.url];
    }
    return _req;
}
#pragma mark - KVO
- (NSArray *)observableKeypaths {
    return [NSArray arrayWithObjects:@"estimatedProgress", @"title", nil];
}
- (void)registerForKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [_wkWebView addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}
- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        @try {
            [_wkWebView removeObserver:self forKeyPath:keyPath];
        } @catch (NSException *exception) {
            NSLog(@"%d %s %@",__LINE__,__PRETTY_FUNCTION__,[exception description]);
        }

    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForWKWebView:) withObject:object waitUntilDone:NO];
    } else {
        [self updateUIForWKWebView:object];
    }
}
#pragma mark Activity
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_hiddenProgressView) {
        [_progressView removeFromSuperview];
    }
    self.navigationController.navigationBarHidden = [self isNavigationHidden];
    self.automaticallyAdjustsScrollViewInsets = ![self isNavigationHidden];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    [self unregisterFromKVO];
    [[self registerJavascriptName] enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
        [_wkWebView.configuration.userContentController removeScriptMessageHandlerForName:name];
    }];
#endif
}
#pragma mark Delegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    _wkWebView.configuration.userContentController = [[WKUserContentController alloc] init];
    //OC注册供JS调用的方法
    [[self registerJavascriptName] enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            [ _wkWebView.configuration.userContentController addScriptMessageHandler:self name:name];
    }];
}
- (void)invokeJavaScript:(NSString *)function{
    if (self.useUIWebView) {
        [self.context evaluateScript:function];
    }else{
        [_wkWebView evaluateJavaScript:function completionHandler:^(id a, NSError *e)
         {
         }];
    }
  
}
- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^ )( id, NSError * error))completionHandler{
    [_wkWebView evaluateJavaScript:function completionHandler:^(id a, NSError *e)
     {
         if (completionHandler) {
             completionHandler(a,e);
         }
     }];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{

    [self invokeIMPFunction:message.body name:message.name];

}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
        ) {
        // 对于跨域，需要手动跳转
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        // 不允许web内跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {

        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (_isFile) {
        NSProgress *prgress = [NSProgress progressWithTotalUnitCount:100];
        [prgress setCompletedUnitCount:100];
        _progressView.progress = prgress;
    }
    self.context=[_uiWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [self.registerJavascriptName enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
        __weak typeof(self) weakSelf = self;
        self.context[name] = ^(id body){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf invokeIMPFunction:body name:name];
        };
    }];
 
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
}

- (void)updateProgress:(NSProgress *)progress webViewProgress:(CHWebViewProress *)webViewProgress{
    _progressView.progress = progress;
}
#pragma makr Private
- (void)invokeIMPFunction:(id)body name:(NSString *)name{
    SEL selector;
    if (body ) {
        selector = NSSelectorFromString([name stringByAppendingString:@":"]);
    }else{
        selector = NSSelectorFromString(name);
    }
    if ([self respondsToSelector:selector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            IMP imp = [self methodForSelector:selector];
            if (body) {
                void (*func)(id, SEL, id) = (void *)imp;
                func(self, selector,body);
            }else{
                void (*func)(id, SEL) = (void *)imp;
                func(self, selector);
            }
        });
  
    }
}
- (void)setUseUIWebView:(BOOL)useUIWebView{
    if (_wkWebView || _uiWebView) {
        
    }else{
        _useUIWebView = useUIWebView;
    }
}
- (void)completionHref:(NSDictionary *)parameters{
    
}
- (BOOL)isNavigationHidden{
    return _hiddenNavtionBar;
}
- (void)updateUIForWKWebView:(WKWebView *)web {
    NSProgress *prgress = [NSProgress progressWithTotalUnitCount:100];
    [prgress setCompletedUnitCount:web.estimatedProgress*100];
    _progressView.progress = prgress;
    if(self.title.length == 0){
        self.title = web.title;
    }
}

- (NSArray <NSString *>*)registerJavascriptName{
    return nil;
}
-(void)dealloc{
    
}
@end
