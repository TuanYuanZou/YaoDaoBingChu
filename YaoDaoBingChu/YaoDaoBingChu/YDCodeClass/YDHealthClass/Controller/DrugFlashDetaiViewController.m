//
//  DrugFlashDetaiViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "DrugFlashDetaiViewController.h"
#define DrugFlashDetailURL @"http://community.111.com.cn/Api/CommunityV1_4/Index/index/id/"

@interface DrugFlashDetaiViewController ()

@end

@implementation DrugFlashDetaiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[DrugFlashDetailURL stringByAppendingString:_id]]]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
