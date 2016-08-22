# CHWebView [中文使用说明文档](https://github.com/chausson/CHWebView/tree/master/ChineseMd)

CHWebView is a lightweigh object-c implemented  for webview.It's WKWebView and UIWebView adapter.
Support progress view when web is loading and html can convenient to call object-c method.

[![CocoaPods](https://cocoapod-badges.herokuapp.com/v/CHWebView/badge.svg)](http://www.cocoapods.org/?q=CHWebView)
![Platform info](http://img.shields.io/cocoapods/p/CHWebView.svg?style=flat)
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

![image](https://github.com/chausson/CHWebView/blob/master/Resource/WebView.gif)

# Features
* You can use UIWebView or WKWebView as usual.
* You can load local resource file in your project more than remote url.
* JavaScript call native method  just coding in a line .
* Support CHWebViewController to load web.


# Install
You can download zip and drag CHWebView File in your project,also you can install with pod.
``` bash
pod 'CHWebView'
```

# Requirements
* iOS 8.0+, 
* Xcode 7.3 or above
* JavaScriptCore
* WebKit

# Init CHWbeView
``` obj-c
    CHWebView *webView = [[CHWebView alloc]initWithFrame:rect];
    [webView loadRequest:self.request];
    webView.delegate = self;
    [self.view addSubview:webView];

```
# If you want change UIWebView
``` obj-c
  - ( instancetype)initWithUIWebView; 
  - ( instancetype)initWithUIWebView:(CGRect)frame;
```
# Also you can use CHWebViewConroller
``` obj-c
- (instancetype)initWithURL:(NSString *)url;

- (instancetype)initWithFile:(NSString *)url;

- (instancetype)initWithURL:(NSString *)url withOutNavtionBar:(BOOL)hidden;

- (instancetype)initWithFile:(NSString *)url withOutNavtionBar:(BOOL)hidden;
```
# JS Call Object-C OC CODE
``` obj-c
- (NSArray<NSString *> *)registerJavascriptName{
    return @[@"fetchMessage",@"show"];
}
- (NSObject *)registerJavaScriptHandler{
    return self;
}
- (void)fetchMessage:(NSDictionary *)dic{
}
- (void)show:(NSDictionary *)dic{

}
```
# JavaScript Code 
Html can found window.NativeBridge object .
window.NativeBridge({f},{j})
@parameter f is native method name maybe it's named show or something else,you can defind it.
@parameter j is parameter used by method.

``` javascript
 function nativeFounction() {
       var obj = { 'message' : 'Hello, JS!', 'numbers' : [ 1, 2, 3 ] };
       window.NativeBridge('fetchMessage',obj)
   }
    function showUIFuction(){
       window.NativeBridge('show')
    }
```
# Object-C Call JavaScript
``` obj-c
- (void)invokeJavaScript:(NSString *)function;

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler;
```
