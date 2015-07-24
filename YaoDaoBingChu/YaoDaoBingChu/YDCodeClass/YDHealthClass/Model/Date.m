//
//  Date.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "Date.h"

@implementation Date

+ (NSString *)currentDateTimeIntervalSinceReferenceDate:(NSDate *)referenceDate
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:referenceDate];
    
    if (timeInterval < 60 )
    {
        return @"刚刚";
    }
    else
    {
        if (timeInterval < 3600 )
        {
            return [NSString stringWithFormat:@"%ld分钟前",(NSInteger)(timeInterval / 60)];
        }
        else
        {
            if (timeInterval <  3600 * 24 )
            {
                return [NSString stringWithFormat:@"%ld小时前",(NSInteger)(timeInterval / 60 / 60)];
            }
            else
                return [NSString stringWithFormat:@"%ld天前",(NSInteger)(timeInterval / 60 / 60 / 24)];
        }
    }
}

@end
