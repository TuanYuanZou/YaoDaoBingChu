//
//  YDRightView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDRightView.h"
#import "YDTabBarButton.h"


//  按钮间的间距
#define TabBarButtonRange 0.0f
//  按钮X坐标
#define TabBarButtonX 0
//  按钮高度
#define TabBarButtonH (self.frame.size.height - 3.0f * TabBarButtonRange)/4.0f
//  按钮宽度
#define TabBarButtonW self.frame.size.width

@implementation YDRightView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor] ;

        self.mapType = [self tabBarButtonWithImage:@"star_highlighted@3x.png" selectImage:@"Satellite.png" title:@"标准" selectTitle:@"卫星" index:0] ;
        self.D3D2 = [self tabBarButtonWithImage:@"D2.png" selectImage:@"D3.png" title:@"2D" selectTitle:@"3D" index:1] ;
        self.traffic = [self tabBarButtonWithImage:@"traffic.png" selectImage:@"block.png" title:@"路况" selectTitle:@"未选" index:2] ;
        self.myAddress = [self tabBarButtonWithImage:@"myAddress.png" selectImage:@"" title:@"位置" selectTitle:@"" index:3] ;
    }
    return self ;
}

#pragma mark - 初始化每一个按钮
- (YDTabBarButton *)tabBarButtonWithImage:(NSString *)image selectImage:(NSString *)selectImage title:(NSString *)title selectTitle:(NSString *)selectTitle index:(int)index
{
    YDTabBarButton * tabBarButton = [[YDTabBarButton alloc]initWithFrame:CGRectMake(TabBarButtonX, (TabBarButtonH + TabBarButtonRange) * index, TabBarButtonW, TabBarButtonH)];
    [tabBarButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    tabBarButton.tag = (index + 1) * 100 ;
    [tabBarButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal] ;
    [tabBarButton setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected] ;
    [tabBarButton setTitle:title forState:UIControlStateNormal] ;
    [tabBarButton setTitle:selectTitle forState:UIControlStateSelected] ;
    [self addSubview:tabBarButton] ;
    [tabBarButton addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return tabBarButton ;
}


#pragma mark - 按钮触发方法
- (void)tabBarButtonAction:(UIButton *)sender
{
    if (self.TabBarButtonBlock == nil) {
        return ;
    }
    self.TabBarButtonBlock(sender) ;
}
@end
