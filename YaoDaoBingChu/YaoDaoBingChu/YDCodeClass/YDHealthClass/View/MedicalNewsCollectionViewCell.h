//
//  MedicalNewsCollectionViewCell.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicaNewsModel.h"

@interface MedicalNewsCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *picImageView;

@property(nonatomic,strong)UILabel *titleLabel;

- (void)setValueForCellWithModel:(MedicaNewsModel *)model;

@end
