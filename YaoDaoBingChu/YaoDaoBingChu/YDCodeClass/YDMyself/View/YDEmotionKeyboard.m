//
//  YDEmotionKeyboard.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/19.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDEmotionKeyboard.h"
#import "YDEmotionTabBar.h"
#import "YDEmotionListView.h"
#import "YDEmotionTool.h"





@interface YDEmotionKeyboard ()
//  容纳表情内容的控件
@property(nonatomic,strong)UIView * contentView  ;

//  1.tabBar
@property(nonatomic,strong)YDEmotionTabBar * tabBar ;
//  2.表情内容(4个)
@property(nonatomic,strong)YDEmotionListView * listViewRecently ;
@property(nonatomic,strong)YDEmotionListView * listViewDefault ;
@property(nonatomic,strong)YDEmotionListView * listViewEmoji ;
@property(nonatomic,strong)YDEmotionListView * listViewWaveFlower ;
@end

@implementation YDEmotionKeyboard
#pragma mark - 懒加载
- (YDEmotionListView *)listViewRecently
{
    if (!_listViewRecently) {
        _listViewRecently = [[YDEmotionListView alloc]init] ;
        //  从沙河中取出“最近”的所有表情
        _listViewRecently.emotions = [YDEmotionTool recentlyEmotions] ;
    }
    return _listViewRecently ;
}

- (YDEmotionListView *)listViewDefault
{
    if (!_listViewDefault) {
        _listViewDefault = [[YDEmotionListView alloc]init] ;
        self.listViewDefault.emotions = [YDEmotionTool defaultEmotions] ;
    }
    return _listViewDefault ;
}

- (YDEmotionListView *)listViewEmoji
{
    if (!_listViewEmoji) {
        _listViewEmoji = [[YDEmotionListView alloc]init] ;
        self.listViewEmoji.emotions = [YDEmotionTool emojiEmotions] ;
    }
    return _listViewEmoji ;
}

- (YDEmotionListView *)listViewWaveFlower
{
    if (!_listViewWaveFlower) {
        _listViewWaveFlower = [[YDEmotionListView alloc]init] ;
        
        self.listViewWaveFlower.emotions = [YDEmotionTool LXHEmotions] ;
    }
    return _listViewWaveFlower ;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  1.contentView
        UIView * contentView = [[UIView alloc]init] ;
        [self addSubview:contentView] ;
        self.contentView = contentView ;
        
        //  2.tabBar
        YDEmotionTabBar * tabBar = [[YDEmotionTabBar alloc]init] ;
        [self addSubview:tabBar] ;
        self.tabBar = tabBar ;
    }
    return self ;
}


//  布局子控件
- (void)layoutSubviews
{
    //  tabbar 尺寸
    CGFloat tabBarW = self.frame.size.width;
    CGFloat tabBarH = 44 ;
    CGFloat tabBarX = 0 ;
    CGFloat tabBarY =  self.frame.size.height - tabBarH;
    self.tabBar.frame = CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH) ;
    self.tabBar.emotionTabBarButtonBlock = ^(UIButton * sender){[self emotionTabBarButtonClink:sender];} ;
    
    //  contentView 尺寸
    CGFloat contentViewX = 0 ;
    CGFloat contentViewY = 0 ;
    CGFloat contentViewW = self.frame.size.width ;
    CGFloat contentViewH =  tabBarY;
    self.contentView.frame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH) ;
    
}



//  监听子控件---切换控件
- (void)emotionTabBarButtonClink:(UIButton *)sender
{
    
    // 移除contentView之前显示的控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //  根据按钮类型不同，切换contentView上面的listView
    switch (sender.tag) {
        case emotionTabBarTypeRecently:
        {
            NSLog(@"最近");
            
            [self.contentView addSubview:self.listViewRecently] ;
            break;
        }
            
        case emotionTabBarTypeDefault:
        {
            NSLog(@"默认");
            [self.contentView addSubview:self.listViewDefault] ;
            break;
        }
            
        case emotionTabBarTypeEmoji:
        {
            NSLog(@"Emoji");
            [self.contentView addSubview:self.listViewEmoji] ;
            break;
        }
            
        case emotionTabBarTypeWaveFlower:
        {
            NSLog(@"浪小花");
            [self.contentView addSubview:self.listViewWaveFlower] ;
            break;
        }
            
        default:
            break;
    }
    
    //  给添加contentView上的子控件，设置尺寸
    YDEmotionListView * ListView = [self.contentView.subviews lastObject] ;
    ListView.frame = self.contentView.bounds ;
    
    
}

@end
