//
//  YDPriceModel.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDPriceModel.h"

@implementation YDPriceModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (YDPriceModel *) modelWithDictionary:(NSMutableDictionary *)dic {
    YDPriceModel *model = [[YDPriceModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
