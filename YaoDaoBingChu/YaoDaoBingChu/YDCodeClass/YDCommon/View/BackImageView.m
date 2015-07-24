//
//  BackImageView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "BackImageView.h"

@implementation BackImageView

- (id)initWithFrame:(CGRect)frame image:(NSString *)image
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = [UIScreen mainScreen].bounds;
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage imageNamed:image];
        
        UIVisualEffectView *visuleffectview = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        
        visuleffectview.frame = self.frame;
        
        visuleffectview.alpha = 0.6;
        
        [self addSubview:visuleffectview];
    }
    return self;
}


@end
