//
//  DrugFlashModel.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "DrugFlashModel.h"

@implementation DrugFlashModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//static DrugFlashModel *drugFlash = nil;
//+ (DrugFlashModel *)shareInstance
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        drugFlash = [[DrugFlashModel alloc] init];
//    });
//    return drugFlash;
//}

//- (NSMutableArray *)loadDataWithDrugFlashURL
//{
//    NSMutableArray *array = [NSMutableArray array];
//    [LORequestManger GET:DrugFlashURL success:^(id response)
//    {
//        NSDictionary *dict = (NSDictionary *)response;
//        [self setValuesForKeysWithDictionary:dict[@"yi18"]];
//        [array addObject:self];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//        NSLog(@"%@",error);
//    }];
//    return array;
//}

@end
