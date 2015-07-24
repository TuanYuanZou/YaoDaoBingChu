//
//  YDMedicationReviewsModel.h
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDMedicationReviewsModel : NSObject
// 用药点评

//{
//    "results": {
//        "Count": 8,
//        "List": [{},{}]
//    },
//    "status": "Ok"
//}

@property (nonatomic, copy) NSString * _id;//                     "_id": 782255,
@property (nonatomic, copy) NSString * content;//                     "content": "请问 丹红注射液40ML配5%葡萄糖注射液250ML浓度高吗",
@property (nonatomic, copy) NSString * effectscore;//                     "effectscore": 2.0,
@property (nonatomic, assign) NSInteger useful;//                     "useful": 94,  赞数
@property (nonatomic, copy) NSString * username;//                     "username": "l"


+ (YDMedicationReviewsModel *) modelWithDictionary:(NSMutableDictionary *)dic;
@end
