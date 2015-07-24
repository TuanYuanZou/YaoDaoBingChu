//
//  YDPriceModel.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDPriceModel : NSObject


@property (nonatomic, assign) NSInteger _id;//"_id": 674175,
@property (nonatomic, copy) NSString * aliascn;//"aliascn": "",
@property (nonatomic, assign) float avgprice;//"avgprice": 46.98,
@property (nonatomic, copy) NSString * basemed;//"basemed": true,
@property (nonatomic, copy) NSString * gongneng;//"gongneng": "益气活血、化瘀通络。用于气虚血滞、脉络瘀阻所致中风中经络，半身不遂、肢体麻木、口眼歪斜、舌强语謇及胸痹心痛、胸闷、心悸、气短；脑梗塞、冠心病心绞痛属上述症候者。",
@property (nonatomic, copy) NSString * listimg;//"listimg": "http://img.39.net/yp/360/xs/674175.jpg",
@property (nonatomic, copy) NSString * medcare;//"medcare": 2,
@property (nonatomic, copy) NSString * namecn;//"namecn": "脑心通胶囊",
@property (nonatomic, copy) NSString * newotc;//"newotc": 3,

@property (nonatomic, copy) NSString * refdrugcompanyname;//"refdrugcompanyname": "陕西步长制药有限公司",
@property (nonatomic, copy) NSString * score;//"score": 3.0,
@property (nonatomic, copy) NSString * titleimg;//"titleimg": "http://img.39.net/yp/360/s/674175.jpg"

+ (YDPriceModel *) modelWithDictionary:(NSMutableDictionary *)dic;

@end
