//
//  MedicalNewsCollectionViewCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "MedicalNewsCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MedicalNewsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 120)];
        [self.contentView addSubview:self.picImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, 100, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setValueForCellWithModel:(MedicaNewsModel *)model
{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.litpic] placeholderImage:[UIImage imageNamed:@"monkey.png"] completed:nil];
    self.titleLabel.text = model.title;
}

@end
