//
//  DrugFlashTableViewCell.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugFlashModel.h"

@interface DrugFlashTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *picImageView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,strong)UIImageView *timeImageView;

@property(nonatomic,strong)UIImageView *countImageView;

@property(nonatomic,strong)UIButton *selectButton;

@property(nonatomic,strong)UIView *appendedView;

- (void)setDataForCell:(DrugFlashModel *)model;

+ (CGFloat)heightForCell:(DrugFlashModel *)model;

@end
