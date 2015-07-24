//
//  HealthLectureCollectionViewCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "HealthLectureCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HealthLectureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 165, 100)];
        //self.picImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_picImageView];
        
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 165, 20)];
        self.myImageView.image = [UIImage imageNamed:@"shadow.png"];
        [self.contentView addSubview:_myImageView];
        
        self.timesLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 90, 10)];
        self.timesLabel.textColor = [UIColor whiteColor];
        self.timesLabel.font = [UIFont systemFontOfSize:12];
        [self.myImageView addSubview:_timesLabel];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 165, 40)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.numberOfLines = 0;
        //self.titleLabel.backgroundColor = [UIColor blueColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setValueForCellWithModel:(HealthLectureModel *)model
{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]placeholderImage:[UIImage imageNamed:@"monkey.png"] completed:nil];
    self.timesLabel.text = [NSString stringWithFormat:@"播放：%@",model.pv];
    self.titleLabel.text = model.title;
}

@end
