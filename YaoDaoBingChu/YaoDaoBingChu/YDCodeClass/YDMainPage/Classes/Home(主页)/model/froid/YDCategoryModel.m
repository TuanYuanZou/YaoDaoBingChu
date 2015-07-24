//
//  YDCategoryModel.m
//  text
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "YDCategoryModel.h"
#import "MJExtension.h"

@implementation YDCategoryModel


- (NSDictionary *)replaceKeyFromPropertyName {
    return @{@"Zore" : @"0", @"ID" : @"id"};
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (YDCategoryModel *) modelWithDictionary:(NSMutableDictionary *)dic {
    YDCategoryModel *model = [[YDCategoryModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
