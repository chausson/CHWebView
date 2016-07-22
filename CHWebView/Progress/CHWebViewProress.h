//
//  CHWebViewProress.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/7/20.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHWebViewProgressDelegate;

@interface CHWebViewProress : NSObject<UIWebViewDelegate>

@property (nonatomic, readonly) NSProgress *currentProgress; // 0.0...1.0

@property (nonatomic, weak) id<CHWebViewProgressDelegate> progressDelegate;

@property (nonatomic, weak) id<UIWebViewDelegate> webViewProxyDelegate;

@end

@protocol CHWebViewProgressDelegate <NSObject>

@optional

- (void)updateProgress:(NSProgress *)progress webViewProgress:(CHWebViewProress *)webViewProgress;

@end