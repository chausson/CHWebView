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


# CHWebView初始化
``` obj-c
    CHWebView *webView = [[CHWebView alloc]initWithFrame:rect];
    [webView loadRequest:self.request];
    webView.delegate = self;
    [self.view addSubview:webView];

```
## 如果你想使用UIWebView,调用一下方法
``` obj-c
- ( instancetype)initWithUIWebView; 
- ( instancetype)initWithUIWebView:(CGRect)frame;

```

# 也可以通过CHWebViewController初始化
``` obj-c
- (instancetype)initWithURL:(NSString *)url;

- (instancetype)initWithFile:(NSString *)url;

```
# JS调用OC代码
## OC代码的实现需要注册名称和注册方法接收的对象,如果继承CHWebViewController则只需要实现注册名称,Controller默认为接收对象。
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
## JS代码的实现,在js的函数中通过使用NativeBridge这样一个对象(web加载完之后自动注入)给Native发送消息,NativeBridge({name},{parameter})name是指注册函数名,parameter是指传入的参数.
``` javascript
   function nativeFounction() {
       var obj = { 'message' : 'Hello, JS!', 'numbers' : [ 1, 2, 3 ] };
       window.NativeBridge('fetchMessage',obj)
   }
    function showUIFuction(){
       window.NativeBridge('show')
    }
```
# Object-C 调用 JS
``` obj-c
- (void)invokeJavaScript:(NSString *)function;

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler;
```

# CHWebView设计图

<img src="https://github.com/chausson/CHWebView/blob/master/Resource/CHWebView.png"  title="CHWebView设计图">

# Correlation Link
http://chausson.github.io/2016/08/09/UIWebView%E4%B8%8EWKWebView/
