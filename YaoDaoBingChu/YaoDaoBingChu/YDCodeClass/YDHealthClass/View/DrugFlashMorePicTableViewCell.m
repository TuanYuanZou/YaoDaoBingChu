//
//  DrugFlashMorePicTableViewCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "DrugFlashMorePicTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Date.h"

@implementation DrugFlashMorePicTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 355, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        //self.titleLabel.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_titleLabel];
        
        for (int i = 0; i < 3; i++)
        {
            self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (100 + 25) * i , 40, 100, 80)];
            self.picImageView.tag = 100 + i;
            self.picImageView.backgroundColor = [UIColor greenColor];
            [self.contentView addSubview:_picImageView];
        }
        
        self.timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 130, 20, 20)];
        self.timeImageView.image = [UIImage imageNamed:@"date2@2x.png"];
        [self.contentView addSubview:_timeImageView];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 130, 70, 20)];
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        //self.timeLabel.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLabel];
        
        self.countImageView = [[UIImageView alloc] initWithFrame:CGRectMake(155, 130, 20, 20)];
        self.countImageView.image = [UIImage imageNamed:@"liulan_img@2x.png"];
        [self.contentView addSubview:_countImageView];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 130, 80, 20)];
        self.countLabel.textColor = [UIColor grayColor];
        self.countLabel.font = [UIFont systemFontOfSize:13];
        //self.countLabel.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_countLabel];
        
        self.selectButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.selectButton.frame = CGRectMake(15, 130, 20, 20);
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"arrow_zk@2x.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.selectButton];
        
        self.appendedView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, kScreenWidth, 30)];
        self.appendedView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.appendedView];

    }
    return self;
}

- (void)setValueForCellWithModel:(DrugFlashModel *)model
{
    for (int i = 0; i < model.attachment.count; i++)
    {
        UIImageView *myImageView = (UIImageView *)[self.contentView viewWithTag:(100 + i)];
        [myImageView sd_setImageWithURL:[NSURL URLWithString:model.attachment[i]] placeholderImage:[UIImage imageNamed:@"monkey.png"] completed:nil];
    }
    self.titleLabel.text = model.title;
    
    self.timeLabel.text = [Date currentDateTimeIntervalSinceReferenceDate:[NSDate dateWithTimeIntervalSince1970:[model.articleAddTime doubleValue]]];
                           
    if ([model.replyCount intValue] >= 10000)
    {
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
        return 200;
    }
    else
    {
        return 160;
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
