//
//  YDToll.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDInstructionsModel.h"
@interface YDToll : NSObject

/**
 *  返回第page业的收藏模型数据 : page从1开始
 */
+ (NSArray *)collectModel:(int)page;

/**
 *  收藏
 */
+ (void)addCollectModel:(YDInstructionsModel *)model;

/**
 *  取消收藏
 */
+ (void)removeCollectModel:(YDInstructionsModel *)model;

/**
 *  判断模型是否被收藏
 */
+ (BOOL)isCollected:(NSString *)model_id;

/**
 *  收藏总数
 */
+ (int)collectCount;
@end
