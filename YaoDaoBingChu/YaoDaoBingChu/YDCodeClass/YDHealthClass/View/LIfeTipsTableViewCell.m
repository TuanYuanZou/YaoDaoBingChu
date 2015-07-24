//
//  LIfeTipsTableViewCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "LIfeTipsTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation LIfeTipsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 70)];
        [self.contentView addSubview:_picImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 250, 25)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
        
        self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 65, 150, 10)];
        self.classLabel.font = [UIFont systemFontOfSize:14];
        self.classLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_classLabel];
    }
    return self;
}

- (void)setValueForCellWithModel:(LifeTipsModel *)model
{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"monkey.png"] completed:nil];
    if ([model.thumb isEqualToString:@""])
    {
        self.picImageView.hidden = YES;
        self.titleLabel.center = CGPointMake(120 + 250 / 2 - 100 - 5, 20 + 25 / 2);
        self.classLabel.center = CGPointMake(120 + 150 / 2 - 100 - 5, 65 + 10 / 2);
    }
    else
    {
        self.picImageView.hidden = NO;
        self.titleLabel.center = CGPointMake(120 + 250 / 2, 20 + 25 / 2);
        self.classLabel.center = CGPointMake(120 + 150 / 2, 65 + 10 / 2);
    }
    self.titleLabel.text = model.title;
    self.classLabel.text = [NSString stringWithFormat:@"分类:%@",model.subcatename];
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
