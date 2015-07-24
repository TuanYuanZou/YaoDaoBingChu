//
//  HealthLectureCollectionReusableView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "HealthLectureCollectionReusableView.h"

@implementation HealthLectureCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 30)];
        //self.sectionView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
        self.sectionView.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:164 / 255.0 blue:96 / 255.0 alpha:1.0];
        [self addSubview:_sectionView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 20)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:16];
        [self.sectionView addSubview:_titleLabel];
    }
    return self;
}

@end
