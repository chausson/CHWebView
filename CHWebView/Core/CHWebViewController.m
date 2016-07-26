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
#import "CHHtmlConverter.h"

@interface CHWebViewController ()<UIWebViewDelegate,CHWebViewProgressDelegate >

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
- (instancetype)initWithURL:(NSString *)url withOutNavtionBar:(BOOL)without{
    if (self = [super init]) {
        _url = [NSURL URLWithString:url];
        _hiddenNavtionBar = without ;
    }
    return self;
}

- (instancetype)initWithFile:(NSString *)url withOutNavtionBar:(BOOL)without{
    if (self = [super init]) {
        _url = [NSURL fileURLWithPath:url];
        _isFile = YES;
        _hiddenNavtionBar = without;
    }
    return self;
}
- (void)initialize{

    _mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height)];
    _mainWebView.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.mainWebView];
    if (!_isFile && ![self isNavigationHidden]) {
        _progressView = [[CHWebProgressView alloc]initWithFrame:CGRectMake(0, [self isNavigationHidden]?0:64, self.view.frame.size.width, 2)];
        _progressProxy = [[CHWebViewProress alloc]init];
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
        _progressView.hidden = YES;
        _mainWebView.delegate = _progressProxy;
    }else{
        _mainWebView.delegate = self;
      
    }

    if (_progressView) {
        [self.view addSubview:_progressView];
    }
    [self.mainWebView loadRequest:self.req];

}
- (NSURLRequest *)req{
    if (!_req) {
        _req = [NSURLRequest requestWithURL:self.url];
    }
    return _req;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = [self isNavigationHidden];
    self.automaticallyAdjustsScrollViewInsets = ![self isNavigationHidden];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    _progressView.hidden = ![self isNavigationHidden];


}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([CHHtmlConverter isNativeActionWithURL:request]) {
        NSDictionary *dic = [CHHtmlConverter fetchParmetersWithURL:request];
        if([CHHtmlConverter isHrefPath:request]){
            NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:[CHHtmlConverter fetchHrefPathWithRequest:request]]];
            [_mainWebView loadRequest:req];
            if ([self respondsToSelector:@selector(completionHref:)]) {
                [self performSelector:@selector(completionHref:) withObject:dic];
            }
            return NO;
        }
        SEL selector = [CHHtmlConverter fetchFounctionNameWithURL:request];
        if ([self respondsToSelector:selector]) {
            IMP imp = [self methodForSelector:selector];
            if (dic) {
                void (*func)(id, SEL, NSDictionary *) = (void *)imp;
                func(self, selector, dic);
            }else{
                void (*func)(id, SEL) = (void *)imp;
                func(self, selector);
            }
        }
        return NO;
    }
    return YES;
}

- (void)updateProgress:(NSProgress *)progress webViewProgress:(CHWebViewProress *)webViewProgress{
    _progressView.progress = progress;
    NSLog(@"progress =%lld",progress.completedUnitCount);
}
- (void)completionHref:(NSDictionary *)parameters{
    
}
- (CGFloat)navigationHeight{
   return  !self.navigationController.navigationBar.hidden &&!self.navigationController.navigationBarHidden && self.navigationController.navigationBar.isTranslucent && self.navigationController != nil?64:0;
}
- (BOOL)isNavigationHidden{
    return _hiddenNavtionBar;
}
@end
