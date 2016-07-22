//
//  CHHtmlConverter.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/7/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHHtmlConverter : NSObject
+ (NSDictionary *)fetchParmetersWithURL:(NSURLRequest  *)request;
+ (SEL )fetchFounctionNameWithURL:(NSURLRequest  *)request;
+ (NSString *)fetchHrefPathWithRequest:(NSURLRequest  *)request;
+ (BOOL )isNativeActionWithURL:(NSURLRequest  *)request;
+ (BOOL )isHrefPath:(NSURLRequest *)request;
@end
