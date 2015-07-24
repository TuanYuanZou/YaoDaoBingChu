//
//  YDDrugCounselingModel.m
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "YDDrugCounselingModel.h"

@implementation YDDrugCounselingModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (YDDrugCounselingModel *) modelWithDictionary:(NSMutableDictionary *)dic {
    YDDrugCounselingModel *model = [[YDDrugCounselingModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
