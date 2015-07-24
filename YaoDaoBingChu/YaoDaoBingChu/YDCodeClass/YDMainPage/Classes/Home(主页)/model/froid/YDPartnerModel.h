//
//  YDPartnerModel.h
//  text
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDPartnerModel : NSObject

@property (nonatomic, copy) NSString * namecn;
@property (nonatomic, copy) NSString * titleimg;

+ (YDPartnerModel *) modelWithDictionary:(NSMutableDictionary *)dic;
@end
