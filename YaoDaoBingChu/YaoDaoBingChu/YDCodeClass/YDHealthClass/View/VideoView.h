//
//  VideoView.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoView : UIView

@property(nonatomic,strong)UIView *myView;

@property(nonatomic,strong)UILabel *currentLabel;

@property(nonatomic,strong)UILabel *totalLabel;

@property(nonatomic,strong)UIButton *playButton;

@property(nonatomic,strong)UIButton *scaleButton;

@property(nonatomic,strong)UISlider *progressSlider;


@end
