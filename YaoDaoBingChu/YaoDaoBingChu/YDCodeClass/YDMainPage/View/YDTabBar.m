//
//  YDTabBar.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDTabBar.h"
#import "YDTabBarButton.h"



@interface YDTabBar ()

//  记录当前被选中的按钮
@property(nonatomic,strong)YDTabBarButton * button ;

@end

@implementation YDTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self)
    {
        //  设置自定义tabBar 的背景颜色
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabBar_backgroundColor.png"]];
    }
    return self ;
}


- (void)addTabBarButtonWithItem:(UITabBarItem *)tabBarItem
{
    //  1.创建按钮
    YDTabBarButton * button = [[YDTabBarButton alloc]init] ;
    [self addSubview:button] ;
    //  设置按钮属性
    button.layer.cornerRadius = 8 ;
    button.layer.masksToBounds = YES ;
    
    //  2.设置数据(封装思想)
    button.item = tabBarItem ;

    
    //  3.监听按钮点击
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown] ;
    //  4.默认选中 0 号按钮
    if (self.subviews.count == 1) {
        [self buttonAction:button] ;
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews] ;
    
    CGFloat buttonY = 0.0f ;
    CGFloat buttonW = self.frame.size.width / 4 ;
    CGFloat buttonH = self.frame.size.height ;

    
    for (int index = 0 ; index < self.subviews.count; index++)
    {
        CGFloat buttonX = self.frame.size.width / 4 * index ;
        YDTabBarButton * button = self.subviews[index] ;
        button.tag = index ;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH) ;
    }
    
}


#pragma mark - 监听按钮点击
- (void)buttonAction:(UIButton *)sender
{
    //  判断协议的遵守者是否实现协议方法
    if ([self.delegate respondsToSelector:@selector(tarBar:fromTabBarItemIndex:toTabBarItemIndex:)]) {
        //  代理干活！！！！
        [self.delegate tarBar:self fromTabBarItemIndex:self.button.tag toTabBarItemIndex:sender.tag] ;
    }
    
    
    
    //  1.当前选中的按钮取消选中
    self.button.selected = NO ;
    //  2.新点击的按钮选中
    sender.selected = YES ;
    //  3.保存新选着的按钮
    self.button = sender ;
}


@end
