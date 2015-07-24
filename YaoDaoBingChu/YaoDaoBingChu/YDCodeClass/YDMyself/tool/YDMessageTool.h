//
//  YDMessageTool.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YDEmotionPlaceholderTextView ;
@class YDMessagePhonesView ;
@class YDMessage ;

@interface YDMessageTool : NSObject

//  1.插入数据
- (void)insertDataWithEmotionPlaceholderTextView:(YDEmotionPlaceholderTextView *)emotionPlaceholderTextView messagePhonesView:(YDMessagePhonesView *)messagePhonesView ;

//  2.取出全部数据
- (NSArray *)messages ;


//   取出数据的全部ID
- (NSArray *)messageIDs ;

//  根据ID查询某一人
- (YDMessage *)messagelWithID:(NSInteger)ID ;

//  共享实例
+ (instancetype)shareMessageTool ;

@end
