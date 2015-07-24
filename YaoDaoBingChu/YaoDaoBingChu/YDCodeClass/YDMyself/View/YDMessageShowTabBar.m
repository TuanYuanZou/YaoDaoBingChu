
//
//  YDMessageShowTabBar.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDMessageShowTabBar.h"

@implementation YDMessageShowTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        //  设置背景颜色
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background@2x.png"]] ;
        
        
        [self setupButtonWithTitlt:@"首页" type:YDMessageShowTabBarButtonTypeFirstPage] ;
        [self setupButtonWithTitlt:@"上一页" type:YDMessageShowTabBarButtonTypeBeforePage] ;
        [self setupButtonWithTitlt:@"下一页" type:YDMessageShowTabBarButtonTypeNextPage] ;
        [self setupButtonWithTitlt:@"末页" type:YDMessageShowTabBarButtonTypeLastPage] ;
    }
    return self ;
}

- (void)setupButtonWithTitlt:(NSString *)title type:(YDMessageShowTabBarButtonType)type
{
    UIButton * button = [[UIButton alloc]init] ;
    button.tag =type ;
    [button setTitle:title forState:UIControlStateNormal] ;
    [self addSubview:button] ;
    [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_normal@2x.png" ] forState:UIControlStateNormal] ;
    [button addTarget:self action:@selector(clinkButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews
{
    NSUInteger count = self.subviews.count ;
    CGFloat buttonW = self.frame.size.width / count ;
    CGFloat buttonH = self.frame.size.height ;
    CGFloat buttonX = 0 ;
    for (int i = 0 ; i < count; i++) {
        buttonX = buttonW * i ;
        UIButton * button = self.subviews[i] ;
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH) ;
    }
}


- (void)clinkButton:(UIButton *)sender
{
    //  返回到控制器
    if (!self.messageShowTabBarBlock) {
        return ;
    }
    self.messageShowTabBarBlock(sender) ;
}

@end
