//
//  HealthLectureRecommendTableViewCell.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthLectureRecommendModel.h"

@interface HealthLectureRecommendTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *picImageView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,strong)UIView *lineView;

- (void)setValueForCellWithModel:(HealthLectureRecommendModel *)model;

@end
