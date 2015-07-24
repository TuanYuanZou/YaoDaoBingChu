//
//  YDLeftViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDLeftViewController.h"
#import "YDLeftViewForMainPage.h"

#import "YDMustHavesController.h"
#import "YDUsuallyModel.h"

@interface YDLeftViewController ()




@end

@implementation YDLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    YDLeftViewForMainPage * leftView = [[YDLeftViewForMainPage alloc]initWithFrame:self.view.bounds] ;
    leftView.leftButtonAction = ^(UIButton * sender){ [self leftButtonAction:sender];};
    
    [self.view addSubview:leftView] ;
    
    
}

//  左抽屉上按钮触发的方法
- (void)leftButtonAction:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 100:
            NSLog(@"100") ;
            
            
//            YDMustHavesController *mustHavesVc = [[YDMustHavesController alloc] init];
//            YDUsuallyModel *model = [[YDUsuallyModel alloc] init];
////            model = self.bannerArray[1];
//            mustHavesVc.titleName = model.title;
//            [self.navigationController pushViewController:mustHavesVc animated:YES];
            
            
            break;
        case 200:
            NSLog(@"200") ;
            break;
        case 300:
            NSLog(@"300") ;
            break;
        case 400:
            NSLog(@"400") ;
            break;
        case 500:
            NSLog(@"500") ;
            break;
        case 600:
            NSLog(@"600") ;
            break;
        case 700:
            NSLog(@"700") ;
            break;
            
        default:
            break;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
