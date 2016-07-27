//
//  CHWebViewController.h
//
//  Created by Chausson on 16/3/9.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHWebViewController : UIViewController

@property (nonatomic, strong)NSURL *url;

@property (nonatomic, strong)UIWebView *mainWebView;


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

/**
 * @brief html前端利用协议中href跳转完后的事件
 */
- (void)completionHref:(NSDictionary *)parameters;

@end
