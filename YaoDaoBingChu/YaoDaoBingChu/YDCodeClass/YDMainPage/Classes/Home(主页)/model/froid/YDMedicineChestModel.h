//
//  YDMedicineChestModel.h
//  text
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDMedicineChestModel : NSObject

// 再建一个model???
@property (nonatomic, copy) NSString * activity_name;//"activity_name": "家庭药箱",
@property (nonatomic, copy) NSString * banner_image_url;//"banner_image_url": "http://openapi.ypt.langma.cn/resources/activity1_banner.png",
@property (nonatomic, copy) NSString * banner_jump_url;//"banner_jump_url": "",


@property (nonatomic, copy) NSString * Zore;//"0": "496003",
@property (nonatomic, copy) NSString * AliasCN;//"AliasCN": "",
@property (nonatomic, copy) NSString * AvgPrice;//"AvgPrice": "2.86",
@property (nonatomic, copy) NSString * BaseMed;//"BaseMed": "0",
@property (nonatomic, copy) NSString * id;//"id": "496003",
@property (nonatomic, copy) NSString * MedCare;//"MedCare": "0",
@property (nonatomic, copy) NSString * NameCN;//"NameCN": "复方胰酶散",
@property (nonatomic, copy) NSString * NewOTC;//"NewOTC": "2",
@property (nonatomic, copy) NSString * TitleImg;//"TitleImg": "http://img.39.net/yy/2013/5/3/629c51b8e29.jpg"

+ (YDMedicineChestModel *) modelWithDictionary:(NSMutableDictionary *)dic;
@end
