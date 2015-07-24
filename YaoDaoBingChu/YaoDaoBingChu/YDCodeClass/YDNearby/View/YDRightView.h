//
//  YDRightView.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDTabBarButton ;

@interface YDRightView : UIView

//  地图类型
@property(nonatomic,strong)YDTabBarButton * mapType ;
//  2D/3D
@property(nonatomic,strong)YDTabBarButton * D3D2 ;
//  路况
@property(nonatomic,strong)YDTabBarButton * traffic ;
//  我的位置
@property(nonatomic,strong)YDTabBarButton * myAddress ;


@property(nonatomic,copy)void(^TabBarButtonBlock)(UIButton * sender) ;

@end
