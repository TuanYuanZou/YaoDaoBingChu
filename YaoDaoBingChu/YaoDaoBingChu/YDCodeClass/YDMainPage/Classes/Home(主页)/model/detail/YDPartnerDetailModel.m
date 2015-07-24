//
//  YDPartnerDetailModel.m
//  text
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "YDPartnerDetailModel.h"

@implementation YDPartnerDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (YDPartnerDetailModel *) modelWithDictionary:(NSMutableDictionary *)dic {
    YDPartnerDetailModel *model = [[YDPartnerDetailModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
