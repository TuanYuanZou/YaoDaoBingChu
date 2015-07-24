//
//  YDEmotionTabBar.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/19.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    emotionTabBarTypeRecently,  //  最近
    emotionTabBarTypeDefault,   //  默认
    emotionTabBarTypeEmoji,     //  Emoji
    emotionTabBarTypeWaveFlower,//  浪小花
    
}EmotionTabBarType;

@interface YDEmotionTabBar : UIView

@property(nonatomic,copy)void (^emotionTabBarButtonBlock)(UIButton * sender) ;

@end
