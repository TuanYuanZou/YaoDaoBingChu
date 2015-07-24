//
//  YDMedicineChestModel.m
//  text
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "YDMedicineChestModel.h"
#import "MJExtension.h"

@implementation YDMedicineChestModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (YDMedicineChestModel *) modelWithDictionary:(NSMutableDictionary *)dic {
    YDMedicineChestModel *model = [[YDMedicineChestModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
- (NSDictionary *)replaceKeyFromPropertyName {
    return @{@"Zore" : @"0", @"ID" : @"id"};
}
@end
