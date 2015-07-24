//
//  HealthLectureRecommendTableViewCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "HealthLectureRecommendTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HealthLectureRecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 150, 100)];
        [self.contentView addSubview:_picImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 20, 180, 40)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 70, 180, 20)];
        self.countLabel.font = [UIFont systemFontOfSize:14];
        self.countLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_countLabel];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 115, kScreenWidth - 20, 1)];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_lineView];
    }
    return self;
}

- (void)setValueForCellWithModel:(HealthLectureRecommendModel *)model
{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"monkey.png"] completed:nil];
    self.titleLabel.text = model.title;
    self.countLabel.text = [NSString stringWithFormat:@"播放次数：%@",model.pv];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
