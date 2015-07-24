//
//  ZOLRequestManger.m
//  MusicPlay
//
//  Created by lanou3g on 15/7/3.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "ZOLRequestManger.h"


#define serverUrl @"http://192.168.1.1:8080/jiekou"
@implementation ZOLRequestManger

+ (void)GET:(NSString *)URL success:(void (^)(id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    //获得请求管理者
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
   
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager.requestSerializer setHTTPShouldHandleCookies:NO];
    
    manager.requestSerializer.timeoutInterval = 10;

    NSString *getStr = URL;
    
    if (![URL hasPrefix:@"http"]) {
        getStr = [NSString stringWithFormat:@"%@%@",serverUrl, URL];
    }
    
    // 发送GET请求
    [manager GET:getStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        
        success(responseDict);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (!operation.responseObject) {
//            NSLog(@"网络错误");
        }
//        Error( operation,error);
    }];
}
@end
