//
//  DrugFlashMorePicTableViewCell.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugFlashModel.h"

@interface DrugFlashMorePicTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIImageView *picImageView;

@property(nonatomic,strong)UIImageView *timeImageView;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UIImageView *countImageView;

@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,strong)UIButton *selectButton;

@property(nonatomic,strong)UIView *appendedView;

- (void)setValueForCellWithModel:(DrugFlashModel *)model;

+ (CGFloat)heightForCell:(DrugFlashModel *)model;

@end
