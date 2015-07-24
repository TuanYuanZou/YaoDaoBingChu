//
//  MedicalNewsDetailTableViewCell.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicalNewsDetailModel.h"

@interface MedicalNewsDetailTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *detailLabel;

- (void)setValueForCellWithModel:(MedicalNewsDetailModel *)model;

+ (CGFloat)heightForCellWithModel:(MedicalNewsDetailModel *)model;

@end
