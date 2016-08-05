//
//  ViewController.m
//  CHWebViewDemo
//
//  Created by Chausson on 16/7/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "ViewController.h"
#import "CHDemoWebController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)baidu:(UIButton *)sender {
    CHWebViewController *web = [[CHWebViewController alloc]initWithURL:@"https://www.baidu.com"];
//    web.useUIWebView = YES;
    [self.navigationController pushViewController:web animated:YES];
}
- (IBAction)wkWebViewDemo:(UIButton *)sender {
    CHDemoWebController *web = [[CHDemoWebController alloc]initWithFile:[[NSBundle mainBundle] pathForResource:@"WKWebViewDemo" ofType:@"html"] withOutNavtionBar:NO];
    [self.navigationController pushViewController:web animated:YES];
    
}
- (IBAction)uiWebViewDemo:(UIButton *)sender {
    CHDemoWebController *web = [[CHDemoWebController alloc]initWithFile:[[NSBundle mainBundle] pathForResource:@"UIWebViewDemo" ofType:@"html"] withOutNavtionBar:NO];
      web.useUIWebView = YES;
    [self.navigationController pushViewController:web animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
