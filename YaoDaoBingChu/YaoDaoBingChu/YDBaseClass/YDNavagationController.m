//
//  YDNavagationController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDNavagationController.h"

@interface YDNavagationController ()

@end

@implementation YDNavagationController

- (void)viewDidLoad {
    [super viewDidLoad];
}





//  重写导航控制器的push方法，当push到二级 及 其以下页面时，隐藏底部的barItem

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //  当前导航控制器的栈中有控制器时，隐藏底部的barItem
    if (self.viewControllers.count > 0)
    {
        //  hidesBottomBarWhenPushed:在推动时隐藏底部的bar
        viewController.hidesBottomBarWhenPushed = YES ;
    }
    [super pushViewController:viewController animated:animated] ;
}




@end
