//
//  CHDemoWebController.m
//  CHWebViewDemo
//
//  Created by Chausson on 16/7/22.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHDemoWebController.h"

@implementation CHDemoWebController

- (void)native:(NSDictionary *)dic{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"I got message from js about =%@",dic] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}
- (void)show{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"I called By show"] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIButton *callJS = [UIButton buttonWithType:UIButtonTypeCustom];
    callJS.frame = CGRectMake(10, 100, 150, 100);
    [callJS setTitle:@"invokeJavaScript" forState:UIControlStateNormal];
    [callJS setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [callJS addTarget:self action:@selector(callJS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:callJS];

}
- (void)callJS{
    [self invokeJavaScript:@"callFromOC('ocCallJS')"]; 
}


- (NSArray<NSString *> *)registerJavascriptName{
    return @[@"native",@"show"];
}
@end
