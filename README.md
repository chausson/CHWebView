[![CocoaPods](https://cocoapod-badges.herokuapp.com/v/CHWebView/badge.svg)](http://www.cocoapods.org/?q=CHWebView)
![Platform info](http://img.shields.io/cocoapods/p/CHWebView.svg?style=flat)
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

# CHWebView
封装iOS UIWebView常用功能的基础控件

![image](https://github.com/chausson/CHWebView/blob/master/Resource/WebView.gif)

# 安装
利用pod安装或者下载工程文件把CHWebView的文件夹拖入工程中
``` object-c
pod 'CHWebView'

```
# 实现功能
* 加载web页面时显示进度条
* 初始化方法拓展增加加载本地文件和远端文件两种方式
* JS调用OC方法封装.

# 使用说明
利用初始化方法加载html,如需要自定义的直接继承CHWebViewController.
如果不需要导航栏在without中设置Yes
``` object-c
/**
 * @brief 根据远端URL地址加载
 */
- (instancetype)initWithURL:(NSString *)url;
/**
 * @brief 根据本地文件路径加载
 */
- (instancetype)initWithFile:(NSString *)url;

- (instancetype)initWithURL:(NSString *)url withOutNavtionBar:(BOOL)hidden;

- (instancetype)initWithFile:(NSString *)url withOutNavtionBar:(BOOL)hidden;

```
# JS调用OC方法
[][web端需要看下实现的协议说明](https://github.com/chausson/CHWebView/blob/master/Resource/JS调用OC的自定义协议.md)

OC这里需要在子类中实现相应的方法名即可
``` object-c
- (void)action:(NSDictionary *)dic{
    NSLog(@"dic=%@",dic);
}
- (void)JSDemo{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
```

