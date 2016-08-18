//
//  ViewController.m
//  CHWebViewDemo
//
//  Created by Chausson on 16/7/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "ViewController.h"
#import "CHDemoWebController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
static NSArray *data = nil;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    data = @[@"LoadURL WKWebView",@"LoadURL UIWebView",@"LoadFile WkWebView",@"LoadFile UIWebView"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell description]];
    cell.textLabel.text = data[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            CHWebViewController *web = [[CHWebViewController alloc]initWithURL:@"https://www.alibaba.com"];
            [self.navigationController pushViewController:web animated:YES];
        } break;
        case 1:{
            CHWebViewController *web = [[CHWebViewController alloc]initWithURL:@"https://www.alibaba.com"];
            web.useUIWebView = YES;
            [self.navigationController pushViewController:web animated:YES];
        } break;
        case 2:{
            CHDemoWebController *web = [[CHDemoWebController alloc]initWithFile:[[NSBundle mainBundle] pathForResource:@"WebViewDemo" ofType:@"html"] withOutNavtionBar:NO];
            web.tintColor = [UIColor greenColor];
            [self.navigationController pushViewController:web animated:YES];
        } break;
        case 3:{
            CHDemoWebController *web = [[CHDemoWebController alloc]initWithFile:[[NSBundle mainBundle] pathForResource:@"WebViewDemo" ofType:@"html"] withOutNavtionBar:NO];
            web.useUIWebView = YES;
            web.hiddenProgressView = YES;
            web.tintColor = [UIColor greenColor];
            [self.navigationController pushViewController:web animated:YES];
        } break;
        default:
            break;
    }
}
@end
