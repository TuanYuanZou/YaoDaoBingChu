//
//  HealthLectureCollectionViewCell.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthLectureModel.h"

@interface HealthLectureCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *picImageView;

@property(nonatomic,strong)UIImageView *myImageView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *timesLabel;

- (void)setValueForCellWithModel:(HealthLectureModel *)model;

@end
