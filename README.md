[![CocoaPods](https://cocoapod-badges.herokuapp.com/v/CHWebView/badge.svg)](http://www.cocoapods.org/?q=CHWebView)
![Platform info](http://img.shields.io/cocoapods/p/CHWebView.svg?style=flat)
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

# CHWebView
CHWebView is a lightweigh object-c implemented basecontroller for webview.It's convenient to use webview between WKWebView with UIWebView,both support progressview when you load web.

![image](https://github.com/chausson/CHWebView/blob/master/Resource/WebView.gif)

# Install
You can download zip and drag CHWebView File in your project,also you can install with pod.
``` bash
pod 'CHWebView'
```

# Features
* Every controller base on CHWebViewContoller will display progreesview when you loading or use CHWebViewContoller init .
* You can load local resource file in your project more than remote url.
* It will be quick to call js function also convenience when js calling native code.
* Support WKWebView and UIWebView.

# Requirements
* iOS 8.0+, 
* Xcode 7.3 or above
* JavaScriptCore
* WebKit

# Init WbeView
``` obj-c
- (instancetype)initWithURL:(NSString *)url;

- (instancetype)initWithFile:(NSString *)url;

- (instancetype)initWithURL:(NSString *)url withOutNavtionBar:(BOOL)hidden;

- (instancetype)initWithFile:(NSString *)url withOutNavtionBar:(BOOL)hidden;

```
# JS Call Object-C
## Object-C Code
``` obj-c
- (NSArray<NSString *> *)registerJavascriptName{
    return @[@"native",@"show"];
}
- (void)native:(NSDictionary *)dic{
}
- (void)show:(id)body{
}
```
## JavaScript Code for WKWebKit
``` javascript
    function nativeFounction() {
    var message = { 'message' : 'Hello, JS!', 'numbers' : [ 1, 2, 3 ] };
        window.webkit.messageHandlers.native.postMessage(message);
    }
    function showUIFuction(){
        window.webkit.messageHandlers.show.postMessage('');
    }
```
## JavaScript Code for UIWebView
``` javascript
    function nativeFounction() {
    var message = { 'message' : 'Hello, JS!', 'numbers' : [ 1, 2, 3 ] };
        native(message);
    }
    function showUIFuction(){
        show('call OC function Show')
    }
```
# Object-C Call JavaScript
``` obj-c
- (void)invokeJavaScript:(NSString *)function;

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler;
```

# Correlation Link
http://www.cocoachina.com/ios/20160810/17337.html
http://www.codedata.cn/cdetail/Objective-C/Webview/1471103893621205

