//
//  YDInstructionsModel.m
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "YDInstructionsModel.h"
#import "MJExtension.h"
@implementation YDInstructionsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (YDInstructionsModel *) modelWithDictionary:(NSMutableDictionary *)dic {
    YDInstructionsModel *model = [[YDInstructionsModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

MJCodingImplementation
@end
