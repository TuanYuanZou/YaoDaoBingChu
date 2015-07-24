//
//  YDUsuallyModel.m
//  YDMainPage
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "YDUsuallyModel.h"
#import "MJExtension.h"
@implementation YDUsuallyModel

- (NSDictionary *)replaceKeyFromPropertyName {
    return @{@"ID" : @"id"};
}
@end


//{
//    "code": "0",
//    "list": {
//        "banner": [{},{},{},{}],
//        "types": [
//                  {
//                      "drug_list": [{},{},{},{}],
//                      "id": "1",
//                      "type_name": "感冒用药"
//                  },
//                  {
//                      "drug_list": [{},{},{},{}],
//                      "id": "2",
//                      "type_name": "慢性病药"
//                  }
//                  ]
//    },
//    "op_type": "1003"
//}