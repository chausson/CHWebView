//
//  CHHtmlConverter.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/7/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHHtmlConverter.h"

@implementation CHHtmlConverter
+ (NSDictionary *)fetchParmetersWithURL:(NSURLRequest  *)request{
    NSMutableDictionary *json ;
    if (request && request.URL) {
            NSArray<NSString *> *components = [request.URL.query componentsSeparatedByString:@"&"];
        if (components.count > 0) {
            json = [NSMutableDictionary new];
        }
        [components enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray<NSString *> *comp = [obj componentsSeparatedByString:@"="];
            [json setObject:comp[1] forKey:comp[0]];
        }];
    }
    return json;
}
+ (SEL )fetchFounctionNameWithURL:(NSURLRequest  *)request{
    if (request && request.URL) {
        NSString *selStr = request.URL.host;
        if ([CHHtmlConverter fetchParmetersWithURL:request]) {
            selStr = [selStr stringByAppendingString:@":"];
        }
        SEL selector = NSSelectorFromString(selStr);
        return selector;
    }
    return nil;
}
+ (NSString *)fetchHrefPathWithRequest:(NSURLRequest  *)request{
    NSString *string = [[NSString alloc] initWithString:request.URL.absoluteString];

    NSString *href = [CHHtmlConverter cutFromString:string header:@"http://" tail:@".com"];
        return href;
}
+ (BOOL )isNativeActionWithURL:(NSURLRequest  *)request{

    if (request.URL && request) {
        NSArray *array = [[NSString stringWithFormat:@"%@",request.URL] componentsSeparatedByString:@"://"];
        if (array.count > 0) {
            return [[array firstObject] isEqualToString:@"app"];
        }
    }
    
    return NO;
    
}
+ (NSString *)cutFromString:(NSString *)aString header:(NSString*)header tail:(NSString *)tail{
    
    
    NSRange headRange = [aString rangeOfString:header];
    
    NSRange tailRange = [aString rangeOfString:tail];
    
    NSRange urlRange = NSMakeRange(headRange.location, tailRange.location + tail.length -headRange.location);
    
    NSString *urlString = [aString substringWithRange:urlRange];
    
    return urlString;
}
+ (BOOL )isHrefPath:(NSURLRequest *)request{
            
    return [request.URL.host isEqualToString:@"href"];
}
@end
