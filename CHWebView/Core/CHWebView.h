//
//  CHWebView.h
//  CHWebViewDemo
//
//  Created by Chausson on 16/8/18.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#import <WebKit/WebKit.h>
#endif
@class CHWebView;
typedef NS_ENUM(NSInteger, CHWebViewNavigationType) {
    CHWebViewNavigationTypeLinkClicked,
    CHWebViewNavigationTypeFormSubmitted,
    CHWebViewNavigationTypeBackForward,
    CHWebViewNavigationTypeReload,
    CHWebViewNavigationTypeFormResubmitted,
    CHWebViewNavigationTypeOther
};
@protocol CHWebViewDelegate <NSObject>
@optional
- (BOOL)webView:(CHWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(CHWebViewNavigationType)navigationType;
- (void)webView:(CHWebView *)webVie  updateProgress:(NSProgress *)progress;
- (void)webView:(CHWebView *)webView withError:(NSError *)error;
- (void)webViewDidFinshLoad:(CHWebView *)webView;
- (void)webViewDidStartLoad:(CHWebView *)webView;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;
#endif
/**
 * @brief Register JavascriptName
 * @return need names array
 */
- (NSArray <NSString *>*)registerJavascriptName;
/**
 * @brief Register Invoke JavaScript observe
 */
- (NSObject *)registerJavaScriptHandler;
@end
@interface CHWebView : UIView

/*! @abstract The web delegate. */
@property ( nonatomic, weak) id <CHWebViewDelegate> delegate;
@property ( nonatomic, readonly, copy) NSURL *URL;
@property ( nonatomic, readonly, copy) NSString *title;
@property ( nonatomic, readonly) NSProgress *estimatedProgress;
@property ( nonatomic, readonly) UIView *webView;// defult is WKWebView ,WKWebView have't cache ,you can choose UIWebView before ViewDidLoad.
@property ( nonatomic, readonly, strong) UIScrollView *scrollView NS_AVAILABLE_IOS(5_0);
@property ( nonatomic, readonly) BOOL canGoBack;
@property ( nonatomic, readonly) BOOL canGoForward;
@property ( nonatomic, readonly, getter=isLoading) BOOL loading;

- ( instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- ( instancetype)initWithUIWebView; // If you want choose UIWebView
- ( instancetype)initWithUIWebView:(CGRect)frame;
/*! @abstract  requested URL.*/
- (void)loadRequest:(  NSURLRequest *)request;

/*! @abstract Sets the webpage contents and base URL.
 @param string The string to use as the contents of the webpage.
 @param baseURL A URL that is used to resolve relative URLs within the document.
 */
- (void)loadHTMLString:(  NSString *)string baseURL:(NSURL *)baseURL;

/*! @abstract Sets the webpage contents and base URL.
 @param data The data to use as the contents of the webpage.
 @param MIMEType The MIME type of the data.
 @param encodingName The data's character encoding name.
 @param baseURL A URL that is used to resolve relative URLs within the document.
 */
- (void)loadData:(  NSData *)data MIMEType:(  NSString *)MIMEType textEncodingName:(  NSString *)textEncodingName baseURL:(  NSURL *)baseURL;

- (void)invokeJavaScript:(  NSString *)function;

- (void)invokeJavaScript:(  NSString *)function completionHandler:( void (^)(  id, NSError * error))completionHandler;

/*! @abstract Reloads the current page.
 */
- (void)reload;
- (void)stopLoading;
- (void)goBack;
- (void)goForward;

@end
