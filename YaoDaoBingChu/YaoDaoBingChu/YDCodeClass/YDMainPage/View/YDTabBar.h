//
//  YDTabBar.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDTabBar ;



//  制定协议 用于处理 点击item 显示对应的 Controller
@protocol YDTabBarDelegate <NSObject>

- (void)tarBar:(YDTabBar *)tarBar fromTabBarItemIndex:(NSInteger )fromIndex toTabBarItemIndex:(NSInteger)toIndex ;

@end

@interface YDTabBar : UIView


@property(nonatomic,assign)id<YDTabBarDelegate>delegate ;

- (void)addTabBarButtonWithItem:(UITabBarItem *)tabBarItem ;


@end
