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

- (instancetype)initWithURL:(NSString *)url withOutNavtionBar:(BOOL)hidden;

- (instancetype)initWithFile:(NSString *)url withOutNavtionBar:(BOOL)hidden;

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
## JS代码的实现,为了统一JS的对象UIWebView和WKWebView以及Android的API,设计的时候没有通过OC去注册一个JS对象，而是选择导入一段JS在这其中使用nativeBridge对象来增加自定义性。需要先导入[nativehelper.js](https://github.com/chausson/CHWebView/blob/master/nativehelper.js)文件就可以调用nativeBridge对象。该对象可以传入两个参数第一个是方法名，第二个是该方法接收的参数,安卓实现中必须先注册一个messageHandles对象。
``` javascript
   function nativeFounction() {
        
       var obj = { 'message' : 'Hello, JS!', 'numbers' : [ 1, 2, 3 ] };
       window.nativeBridge('fetchMessage',obj)
   }
    function showUIFuction(){
       window.nativeBridge('show')
    }
```
# Object-C 调用 JS
``` obj-c
- (void)invokeJavaScript:(NSString *)function;

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler;
```

# Correlation Link
http://chausson.github.io/2016/08/09/UIWebView%E4%B8%8EWKWebView/
