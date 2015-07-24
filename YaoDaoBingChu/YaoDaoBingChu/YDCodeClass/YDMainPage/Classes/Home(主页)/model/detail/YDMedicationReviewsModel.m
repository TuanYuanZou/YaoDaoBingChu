//
//  YDMedicationReviewsModel.m
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "YDMedicationReviewsModel.h"

@implementation YDMedicationReviewsModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (YDMedicationReviewsModel *) modelWithDictionary:(NSMutableDictionary *)dic {
    YDMedicationReviewsModel *model = [[YDMedicationReviewsModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
