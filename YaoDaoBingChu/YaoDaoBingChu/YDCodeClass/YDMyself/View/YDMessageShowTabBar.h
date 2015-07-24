//
//  YDMessageShowTabBar.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YDMessageShowTabBarButtonTypeFirstPage,  //  首页
    YDMessageShowTabBarButtonTypeBeforePage,  //  上一页
    YDMessageShowTabBarButtonTypeNextPage,  //  下一页
    YDMessageShowTabBarButtonTypeLastPage,  //  末页
}YDMessageShowTabBarButtonType;

@interface YDMessageShowTabBar : UIView


//  block传值
@property(nonatomic,copy)void (^messageShowTabBarBlock)(UIButton * sender) ;

@end
