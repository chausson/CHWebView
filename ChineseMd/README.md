# CHWebView
CHWebView is a lightweigh object-c implemented  for webview.It's convenient to use webview between WKWebView with UIWebView,both support progressview when you load web.

[![CocoaPods](https://cocoapod-badges.herokuapp.com/v/CHWebView/badge.svg)](http://www.cocoapods.org/?q=CHWebView)
![Platform info](http://img.shields.io/cocoapods/p/CHWebView.svg?style=flat)
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

![image](https://github.com/chausson/CHWebView/blob/master/Resource/WebView.gif)

# Features
* Every controller base on CHWebViewContoller will display progreesview when you loading or use CHWebViewContoller init .
* You can load local resource file in your project more than remote url.
* Coding JavaScript call native method in 1 line code.
* Support WKWebView and UIWebView.
* 

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

# Init WbeView
``` obj-c
- (instancetype)initWithURL:(NSString *)url;

- (instancetype)initWithFile:(NSString *)url;

- (instancetype)initWithURL:(NSString *)url withOutNavtionBar:(BOOL)hidden;

- (instancetype)initWithFile:(NSString *)url withOutNavtionBar:(BOOL)hidden;

```
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
# JavaScript Code 
First of all you should import the nativehelper.js in file resouse/nativehelper.js then you can found window.nativeFunc object .
window.nativeFunc({f},{j})
@parameter f is native method name maybe it's named show or something else,you can defind it.
@parameter j is parameter used by method.

``` javascript
   function nativeFounction() {
        
       var obj = { 'message' : 'Hello, JS!', 'numbers' : [ 1, 2, 3 ] };
       nativeFunc('native',obj)
   }
    function showUIFuction(){
       nativeFunc('show')
    }
```
# Object-C Call JavaScript
``` obj-c
- (void)invokeJavaScript:(NSString *)function;

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler;
```

# Correlation Link
http://chausson.github.io/2016/08/09/UIWebView%E4%B8%8EWKWebView/
