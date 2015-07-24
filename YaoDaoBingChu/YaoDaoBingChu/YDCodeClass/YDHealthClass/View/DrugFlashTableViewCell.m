//
//  DrugFlashTableViewCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "DrugFlashTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Date.h"

@implementation DrugFlashTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 230, 50)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        //self.titleLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_titleLabel];
        
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(265, 10, 100, 80)];
        //self.picImageView.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_picImageView];
        
        self.timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 70, 20, 20)];
        self.timeImageView.image = [UIImage imageNamed:@"date2@2x.png"];
        [self.contentView addSubview:_timeImageView];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 70, 80, 20)];
        self.timeLabel.textColor = [UIColor grayColor];
        //self.timeLabel.backgroundColor = [UIColor grayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_timeLabel];
        
        self.countImageView = [[UIImageView alloc] initWithFrame:CGRectMake(155, 70, 20, 20)];
        self.countImageView.image = [UIImage imageNamed:@"liulan_img@2x.png"];
        [self.contentView addSubview:_countImageView];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 70, 75, 20)];
        self.countLabel.textColor = [UIColor grayColor];
        //self.countLabel.backgroundColor = [UIColor grayColor];
        self.countLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_countLabel];
        
        self.selectButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.selectButton.frame = CGRectMake(15, 70, 20, 20);
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"arrow_zk@2x.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.selectButton];
        
        self.appendedView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 30)];
        self.appendedView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.appendedView];
    }
    return self;
}

- (void)setDataForCell:(DrugFlashModel *)model
{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:[model.attachment firstObject]] placeholderImage:[UIImage imageNamed:@"monkey.png"] completed:nil];
    
    self.titleLabel.text = model.title;
    self.timeLabel.text = [Date currentDateTimeIntervalSinceReferenceDate:[NSDate dateWithTimeIntervalSince1970:[model.articleAddTime doubleValue]]];
    
    if ([model.replyCount intValue] >= 10000) {
        self.countLabel.text = [NSString stringWithFormat:@"阅读%d.%d万",[model.replyCount intValue] / 10000,[model.replyCount intValue] % 10000 / 1000];
    }
    else
    {
        self.countLabel.text = [NSString stringWithFormat:@"阅读%@",model.replyCount];
    }
    
    if (model.isSelect == YES)
    {
        [self.contentView addSubview:self.appendedView];
        [UIView animateWithDuration:0.5 animations:^{
            self.selectButton.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
    else
    {
        [self.appendedView removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
            self.selectButton.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}

+ (CGFloat)heightForCell:(DrugFlashModel *)model
{
    if (model.isSelect == YES)
    {
        return 140;
    }
    else
    {
        return 100;
    }
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
