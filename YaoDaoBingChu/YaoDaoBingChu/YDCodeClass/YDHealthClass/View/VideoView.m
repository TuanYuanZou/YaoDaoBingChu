//
//  VideoView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "VideoView.h"

@implementation VideoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        self.myView.backgroundColor = [UIColor grayColor];
        self.myView.alpha = 0.8;
        [self addSubview:_myView];
        
        self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.playButton.frame = CGRectMake(15, 10, 20, 20);
        //[self.playButton setBackgroundImage:[UIImage imageNamed:@"player_play_hl@2x.png"] forState:UIControlStateNormal];
        [self.myView addSubview:_playButton];
        
        self.currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, 50, 20)];
        self.currentLabel.textColor = [UIColor whiteColor];
        self.currentLabel.font = [UIFont systemFontOfSize:12];
        self.currentLabel.text = @"00:00";
        [self.myView addSubview:_currentLabel];
        
        self.progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(105, 15, 150, 10)];
        self.progressSlider.minimumTrackTintColor = [UIColor greenColor];
        self.progressSlider.maximumTrackTintColor = [UIColor whiteColor];
        self.progressSlider.thumbTintColor = [UIColor greenColor];
        [ self.progressSlider setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateNormal];
        [ self.progressSlider setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateHighlighted];
        [self.myView addSubview:_progressSlider];
        
        self.totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(265, 10, 60, 20)];
        self.totalLabel.textColor = [UIColor whiteColor];
        self.totalLabel.text = @"00:00";
        self.totalLabel.font = [UIFont systemFontOfSize:12];
        [self.myView addSubview:_totalLabel];
        
        self.scaleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.scaleButton setBackgroundImage:[UIImage imageNamed:@"quanpin.png"] forState:UIControlStateNormal];
        self.scaleButton.frame = CGRectMake(335, 10, 20, 20);
        [self.myView addSubview:_scaleButton];
    }
    return self;
}

@end
