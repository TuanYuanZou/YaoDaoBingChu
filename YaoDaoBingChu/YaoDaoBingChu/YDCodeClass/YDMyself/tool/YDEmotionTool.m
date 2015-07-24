//
//  YDEmotionTool.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDEmotionTool.h"

#import "MJExtension.h"
#import "YDEmotion.h"


#define kRecentlyEmotionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentlyEmotion.sqlite"]


static NSArray * _defaultEmotions,*_emojiEmotions,*_LXHEmotions ;

@implementation YDEmotionTool




//  添加最近表情
+ (void)addRecentlyEmotion:(YDEmotion *)emotion
{
    
    
    //  加载沙盒中的表情数据
    NSMutableArray * emotions = (NSMutableArray *)[self recentlyEmotions] ;
    
    if (emotions == nil) {
        emotions = [NSMutableArray array] ;
    }
    //  删除重复的表情
    [emotions removeObject:emotion] ;    
    
    //  将表情放到数组的最前面
    [emotions insertObject:emotion atIndex:0];
    //  讲所有表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:emotions toFile:kRecentlyEmotionPath] ;
    
}
//  取出所有的最近表情
+ (NSArray *)recentlyEmotions
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kRecentlyEmotionPath] ;
}


//  取出所有的默认表情
+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString * path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/default/info.plist" ofType:nil] ;
        _defaultEmotions = [YDEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]] ;
    }
    return  _defaultEmotions;
}

//  取出所有的Emoji表情
+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        
        NSString * path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil] ;
        _emojiEmotions = [YDEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]] ;
    }
    return _emojiEmotions ;
    
}


//  取出所有的lxh表情
+ (NSArray *)LXHEmotions
{
    if (!_LXHEmotions) {
        NSString * path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil] ;
        _LXHEmotions = [YDEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]] ;
    }
    return  _LXHEmotions;
    
}



+ (YDEmotion *)emotionWithChs:(NSString *)chs
{
    NSArray *defaults = [self defaultEmotions];
    for (YDEmotion *emotion in defaults) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    NSArray *lxhs = [self LXHEmotions];
    for (YDEmotion *emotion in lxhs) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    
    return nil;
}
@end
