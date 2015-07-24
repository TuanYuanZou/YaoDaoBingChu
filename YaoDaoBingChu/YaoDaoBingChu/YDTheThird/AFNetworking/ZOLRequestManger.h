//
//  ZOLRequestManger.h
//  MusicPlay
//
//  Created by lanou3g on 15/7/3.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface ZOLRequestManger : NSObject

+ (void)GET:(NSString *)URL success:(void (^)(id responseObject))success
    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
