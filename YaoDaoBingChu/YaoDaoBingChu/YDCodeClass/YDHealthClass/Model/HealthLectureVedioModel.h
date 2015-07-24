//
//  HealthLectureVedioModel.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class HealthLectureVedioModel;

@protocol HealthLectureVedioModelDelegate <NSObject>

- (void)audioStreamer:(HealthLectureVedioModel *)streamer didPlayingWithProgress:(float)progress totalTime:(float)totalTime;

@end

@interface HealthLectureVedioModel : NSObject

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *v_720;

@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *listid;


@property(nonatomic,strong)AVPlayer *healthLecturePlayer;

@property(nonatomic,strong)AVPlayerItem *healthLecturePlayerItem;

@property(nonatomic,assign)BOOL isPlaying;

+ (HealthLectureVedioModel *)shareInstance;

@end
