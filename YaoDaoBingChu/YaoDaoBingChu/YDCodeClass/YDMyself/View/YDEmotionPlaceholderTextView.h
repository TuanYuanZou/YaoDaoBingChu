//
//  YDEmotionPlaceholderTextView.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDPlaceholderTextView.h"

@class YDEmotion ;

@interface YDEmotionPlaceholderTextView : YDPlaceholderTextView



//  插入表情
- (void)insertEmotion:(YDEmotion *)emotion ;

//  将textView中的图文内容转化为 NSString
- (NSString *)fullText ;


@end
