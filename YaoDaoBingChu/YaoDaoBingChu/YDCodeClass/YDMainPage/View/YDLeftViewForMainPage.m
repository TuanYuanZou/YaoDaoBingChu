//
//  YDLeftViewForMainPage.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDLeftViewForMainPage.h"
#import "YDLeftButton.h"


#define YDLeftButtonX 30
#define YDLeftButtonWith 200
#define YDLeftButtonHeight 50

// 第一个按钮距离 顶部的y坐标
#define YDLeftButtonWithTopY 100
//  临近两个按钮的距离
#define YDLeftButtonRange 60


@interface YDLeftViewForMainPage ()

// 专题标题数组
@property(nonatomic,strong)NSArray * titleArray ;
// 专题图标名称数组
@property(nonatomic,strong)NSArray * iconNameArray ;

@end


@implementation YDLeftViewForMainPage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self)
    {
        for (int i = 0 ; i < 7 ; i++)
        {
            
            [self setupButtonWithRect:CGRectMake(YDLeftButtonX, YDLeftButtonWithTopY + i* YDLeftButtonRange, YDLeftButtonWith, YDLeftButtonHeight) index:i] ;
        }
        
    }
    self.backgroundColor = [UIColor cyanColor] ;
    return self ;
}

#pragma mark - 创建左侧页面的每一个按钮
- (void)setupButtonWithRect:(CGRect)rect index:(int)index
{
    YDLeftButton * button = [YDLeftButton buttonWithType:UIButtonTypeSystem] ;
    button.frame = rect ;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside] ;
    button.tag = 100 * (index + 1) ;
    NSString * iconName = [NSString stringWithFormat:@"classify_%@.png",self.iconNameArray[index]] ;
    [button setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal] ;
    [button setTitle:self.titleArray[index] forState:UIControlStateNormal] ;
    //button.backgroundColor = [UIColor grayColor] ;
    [self addSubview:button] ;
}



#pragma mark - 点击按钮触发的方法
- (void)buttonAction:(UIButton *)sender
{
    if (self.leftButtonAction == nil) {
        return ;
    }
    //  block 回调
    self.leftButtonAction(sender) ;
}


#pragma mark - 专题标题数组
- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[@"家庭药箱",@"感冒用药",@"维生素/钙",@"慢性疾病",@"妇科用药",@"男科用药",@"儿童用药"];
    }
    return _titleArray ;
}

#pragma mark - 专题图标名称数组
- (NSArray *)iconNameArray
{
    if (!_iconNameArray)
    {
        _iconNameArray = @[@"jtyx",@"gmyy",@"wssg",@"mxby",@"fkyy",@"nkyy",@"etyy"];
    }
    return _iconNameArray ;
}



@end
