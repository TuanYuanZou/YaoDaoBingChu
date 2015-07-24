//
//  YDCategoryModel.h
//  text
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDCategoryModel : NSObject

@property (nonatomic, copy) NSString * type_name;

@property (nonatomic, copy) NSString * Zore;//"0": "508806",
@property (nonatomic, copy) NSString * AliasCN;//"AliasCN": "",
@property (nonatomic, copy) NSString * AvgPrice;//"AvgPrice": "27.48",
@property (nonatomic, copy) NSString * BaseMed;//"BaseMed": "0",

@property (nonatomic, copy) NSString * id;//"id": "508806",
@property (nonatomic, copy) NSString * MedCare;//"MedCare": "0",
@property (nonatomic, copy) NSString * NameCN;//"NameCN": "小儿肺热咳喘口服液",
@property (nonatomic, copy) NSString * NewOTC;//"NewOTC": "1",
@property (nonatomic, copy) NSString * TitleImg;//"TitleImg": "http://img.39.net/yp/360/s/508806.jpg"

+ (YDCategoryModel *) modelWithDictionary:(NSMutableDictionary *)dic;
@end
