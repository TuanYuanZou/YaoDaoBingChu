//
//  YDEmotionTabBar.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/19.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDEmotionTabBar.h"
#import "YDEmotionTabBarButton.h"

@interface YDEmotionTabBar ()

@property(nonatomic,strong)YDEmotionTabBarButton * currentButton ;



@end

@implementation YDEmotionTabBar



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        [self setupButtonWithTitle:@"最近" type:emotionTabBarTypeRecently];
        [self setupButtonWithTitle:@"默认" type:emotionTabBarTypeDefault];
        [self setupButtonWithTitle:@"Emoji" type:emotionTabBarTypeEmoji];
        [self setupButtonWithTitle:@"浪小花" type:emotionTabBarTypeWaveFlower];
    }
    return self ;
}


//  创建按钮
- (void )setupButtonWithTitle:(NSString *)title type:(EmotionTabBarType)type
{
    YDEmotionTabBarButton * button = [[YDEmotionTabBarButton alloc]init] ;
    button.tag = type ;
    [button setTitle:title forState:UIControlStateNormal];    
    //  设置背景图片
    NSString * image = nil ;
    NSString * selectImage = nil ;
    if (self.subviews.count == 0) {
        image = @"compose_emotion_table_left_normal@2x.png" ;
        selectImage = @"compose_emotion_table_left_selected@2x.png" ;
    }else if (self.subviews.count == 3){
        image = @"compose_emotion_table_right_normal@2x.png" ;
        selectImage = @"compose_emotion_table_right_selected@2x.png" ;
    }else{
        image = @"compose_emotion_table_mid_normal@2x.png" ;
        selectImage = @"compose_emotion_table_mid_selected@2x.png" ;
    }
    [button addTarget:self action:@selector(clink:) forControlEvents:UIControlEventTouchDown] ;
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    [self addSubview:button] ;
    
    
}


// 布局
- (void)layoutSubviews
{
    NSUInteger count = self.subviews.count ;
    
    CGFloat btnY = 0;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnW = self.frame.size.width / count;
    for (NSUInteger i = 0 ; i < count ; i++) {
        CGFloat btnX = btnW * i ;
        YDEmotionTabBarButton * btn = self.subviews[i] ;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH) ;
    }
}


- (void)clink:(YDEmotionTabBarButton *)sender
{
    self.currentButton.enabled = YES ;
    sender.enabled = NO ;
    self.currentButton = sender ;
     if (self.emotionTabBarButtonBlock == nil) {
        return ;
    }
    self.emotionTabBarButtonBlock(sender) ;
}


//  重写block的setting方法
- (void)setEmotionTabBarButtonBlock:(void (^)(UIButton *))emotionTabBarButtonBlock
{
    _emotionTabBarButtonBlock = [emotionTabBarButtonBlock copy];
    
    //  选中默认按钮
    YDEmotionTabBarButton * emotionTabBarDefaultButton = (YDEmotionTabBarButton *)[self viewWithTag:emotionTabBarTypeDefault ];
    [self clink:emotionTabBarDefaultButton] ;
    
}
@end
