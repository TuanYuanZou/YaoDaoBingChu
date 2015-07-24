//
//  DrugFlashModel.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrugFlashModel : NSObject

@property(nonatomic,copy)NSString *articleAddTime;

@property(nonatomic,copy)NSString *articleId;

@property(nonatomic,copy)NSArray *attachment;

@property(nonatomic,copy)NSString *replyCount;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *tips;

@property(nonatomic,assign)BOOL isSelect;

//+ (DrugFlashModel *)shareInstance;

//- (NSMutableArray *)loadDataWithDrugFlashURL;

@end
