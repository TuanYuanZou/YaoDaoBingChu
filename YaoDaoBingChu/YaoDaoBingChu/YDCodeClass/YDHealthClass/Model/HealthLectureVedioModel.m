//
//  HealthLectureVedioModel.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "HealthLectureVedioModel.h"

@implementation HealthLectureVedioModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

static HealthLectureVedioModel *videoModel = nil;
+ (HealthLectureVedioModel *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        videoModel = [[HealthLectureVedioModel alloc] init];
    });
    return videoModel;
}

- (AVPlayer *)healthLecturePlayer
{
    if (!_healthLecturePlayer)
    {
        _healthLecturePlayer = [[AVPlayer alloc] init];
    }
    return _healthLecturePlayer;
}

@end
