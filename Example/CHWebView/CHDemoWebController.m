//
//  CHDemoWebController.m
//  CHWebViewDemo
//
//  Created by Chausson on 16/7/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHDemoWebController.h"

@implementation CHDemoWebController

- (void)fetchMessage:(NSDictionary *)dic{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"I got message from js about =%@",dic] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}
- (void)show{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"Show Function"] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIButton *callJS = [UIButton buttonWithType:UIButtonTypeCustom];
    callJS.frame = CGRectMake(10, 100, 80, 100);
    [callJS setTitle:@"CallJS" forState:UIControlStateNormal];
   // [callJS setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [callJS addTarget:self action:@selector(callJS) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:callJS];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:callJS];
    self.navigationItem.rightBarButtonItem = right;
}
- (void)callJS{
    [self invokeJavaScript:@"callFromOC('Object-C invoke JS')"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;    
}

- (NSArray<NSString *> *)registerJavascriptName{
    return @[@"fetchMessage",@"show"];
}
@end
