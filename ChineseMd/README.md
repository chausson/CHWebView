# CHWebView
CHWebView 是一个基于OC代码实现的WebView轻量级组件,适配UIWebView和WKWebView的API封装成统一的类去使用,并且在加载网页的时候提供进度条,同时简化JS与OC调用的方式。

[![CocoaPods](https://cocoapod-badges.herokuapp.com/v/CHWebView/badge.svg)](http://www.cocoapods.org/?q=CHWebView)
![Platform info](http://img.shields.io/cocoapods/p/CHWebView.svg?style=flat)
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

![image](https://github.com/chausson/CHWebView/blob/master/Resource/WebView.gif)

# 功能
* 自如的切换WKWebView以及UIWebView的使用
* 提供了网页加载进度条
* 利用一行代码实现JS与OC和Android的交互
* 提供基类控制器方便快捷的加载网页

# 安装
目前支持POD安装,或者可以实现下载project将CHWebView文件夹拖入你的工程中
``` bash
pod 'CHWebView'
```

# 要求
* iOS 8.0+, 
* Xcode 7.3 or above
* JavaScriptCore
* WebKit

# 利用CHWebViewController初始化
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
