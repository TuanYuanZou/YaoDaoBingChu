//
//  YDTabBarButton.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//103 113 147

#import "YDTabBarButton.h"

#import "YDBadgeValueButton.h"


//  图标的比例
#define YDTabBarButtonImageRatio 0.6


@interface YDTabBarButton ()

//  添加一个数字提醒按钮
@property(nonatomic,strong)YDBadgeValueButton * badgeBUtton ;

@end

@implementation YDTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //  图片居中
        self.imageView.contentMode = UIViewContentModeCenter ;
        //  文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter ;
        //  文字颜色 和 大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:kColor(110,166,226) forState:UIControlStateNormal] ;
        
        
        //  设置按钮选中背景颜色
        [self setBackgroundImage:[UIImage imageNamed:@"tabBarItem_Select_image.png"] forState:UIControlStateSelected];
    }
    
    //  添加一个数字提醒按钮
    YDBadgeValueButton * badgeBUtton = [YDBadgeValueButton buttonWithType:UIButtonTypeSystem] ;    
    
    [self addSubview:badgeBUtton] ;
    //  自动布局
    badgeBUtton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin ;
    self.badgeBUtton = badgeBUtton ;
    
    return self ;
}


#pragma mark-取消按钮高亮
- (void)setHighlighted:(BOOL)highlighted
{
    
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * YDTabBarButtonImageRatio) ;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height * YDTabBarButtonImageRatio, contentRect.size.width, contentRect.size.height * (1 - YDTabBarButtonImageRatio)) ;
}


#pragma mark - 重写setting方法
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    
    //  KVO监听  item的badgeValue属性是否改变
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil] ;
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil] ;
    
    
    
    // 无论是新创建 tabBarItem 还是 tabBarItem的属性发生改变了，都会调用 observe方法
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil] ;
    
}

#pragma mark - badgeValue属性改变触发该方法,从新为该属性赋值。
#pragma mark - image属性改变触发该方法,从新为该属性赋值。
#pragma mark - title属性改变触发该方法,从新为该属性赋值。
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //  设置图片
    [self setImage:self.item.image forState:UIControlStateNormal] ;
    //  设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal] ;
    
    //  设置提醒数字
    self.badgeBUtton.badgeValue = self.item.badgeValue ;
    
    // 设置提醒数字的位置
    CGFloat badgeButtonY = 0;
    CGFloat badgeButtonX = self.frame.size.width - self.badgeBUtton.frame.size.width - 5;
    CGRect badgeButtonF = self.badgeBUtton.frame ;
    badgeButtonF.origin.x = badgeButtonX ;
    badgeButtonF.origin.y = badgeButtonY ;
    self.badgeBUtton.frame = badgeButtonF ;
    
}


#pragma mark - 移除观察者，否则会发生野指针错误
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"] ;
}

@end
