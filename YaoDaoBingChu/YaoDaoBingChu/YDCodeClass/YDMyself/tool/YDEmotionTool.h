//
//  YDEmotionTool.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YDEmotion ;
@interface YDEmotionTool : NSObject

//  添加最近表情
+ (void)addRecentlyEmotion:(YDEmotion *)emotion ;
//  取出所有的最近表情
+ (NSArray *)recentlyEmotions ;
//  取出所有的默认表情
+ (NSArray *)defaultEmotions ;
//  取出所有的Emoji表情
+ (NSArray *)emojiEmotions ;
//  取出所有的lxh表情
+ (NSArray *)LXHEmotions ;


/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (YDEmotion *)emotionWithChs:(NSString *)chs;


@end
