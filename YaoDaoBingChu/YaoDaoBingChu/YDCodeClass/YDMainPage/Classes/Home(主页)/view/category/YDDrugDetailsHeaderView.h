//
//  YDDrugDetailsHeaderView.h
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDInstructionsModel.h"
@interface YDDrugDetailsHeaderView : UIView
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *company;
@property (nonatomic, strong) UILabel *desc;

//@property (nonatomic, strong) UIButton *collect;


- (void)setModel:(YDInstructionsModel *)model;
@end
