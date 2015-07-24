//
//  LIfeTipsTableViewCell.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LifeTipsModel.h"

@interface LIfeTipsTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *picImageView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *classLabel;

- (void)setValueForCellWithModel:(LifeTipsModel *)model;

@end
