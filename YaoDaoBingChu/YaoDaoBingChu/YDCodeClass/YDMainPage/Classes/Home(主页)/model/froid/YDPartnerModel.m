//
//  YDPartnerModel.m
//  text
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "YDPartnerModel.h"

@implementation YDPartnerModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (YDPartnerModel *) modelWithDictionary:(NSMutableDictionary *)dic {
    YDPartnerModel *model = [[YDPartnerModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
