//
//  YDDrugCounselingModel.h
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDDrugCounselingModel : NSObject

@property (nonatomic, copy) NSString * age;//"age": "30岁",
@property (nonatomic, copy) NSString * answer;//"answer": "你好，根据你的描述情况首先注意观察宝宝的起来，以上药物不是抗生素的",
@property (nonatomic, copy) NSString * doctorname;//"doctorname": "贺泽威",
@property (nonatomic, copy) NSString * mainbody;//"mainbody": "病情描述:医生你好，小儿肺热咳喘口服液跟小儿消积口服液这两种是抗生素药吗",
@property (nonatomic, copy) NSString * sex;//"sex": "",

@property (nonatomic, copy) NSString * username;

//{
//    "results": {
//        "Count": 855,
//        "List": [{},{}]
//    },
//    "status": "Ok"
//}
+ (YDDrugCounselingModel *) modelWithDictionary:(NSMutableDictionary *)dic;
@end
