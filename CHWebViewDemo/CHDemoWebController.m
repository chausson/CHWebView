//
//  CHDemoWebController.m
//  CHWebViewDemo
//
//  Created by Chausson on 16/7/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHDemoWebController.h"

@implementation CHDemoWebController
- (void)action:(NSDictionary *)dic{
    NSLog(@"dic=%@",dic);
}
- (void)JSDemo{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
- (void)completionHref:(NSDictionary *)parameters{
    NSLog(@"href Json = %@",parameters);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mainWebView.backgroundColor = [UIColor grayColor];
    self.navigationController.navigationBarHidden = YES;
}
@end
