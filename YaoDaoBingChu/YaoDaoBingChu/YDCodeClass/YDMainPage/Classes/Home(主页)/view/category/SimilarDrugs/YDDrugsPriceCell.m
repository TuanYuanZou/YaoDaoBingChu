//
//  YDDrugsPriceCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDDrugsPriceCell.h"

@interface YDDrugsPriceCell ()
@property (weak, nonatomic) IBOutlet UILabel *addre;
@property (weak, nonatomic) IBOutlet UIButton *pic;

@end

@implementation YDDrugsPriceCell


- (void)cellSetModel:(YDDrugPriceModel *)model {
    
    
    self.addre.text = model.refpharmaciesnamecn;
    
    NSString *price = [NSString stringWithFormat:@"%f",model.price];
    if (model.price != 0.0) {
        [self.pic setTitle:[NSString stringWithFormat:@"￥%@",price] forState:UIControlStateNormal] ;
        NSUInteger dotLoc = [self.pic.titleLabel.text rangeOfString:@"."].location;
        if (dotLoc != NSNotFound) {
            // 超过2位小数
            if (self.pic.titleLabel.text.length - dotLoc > 3) {
               self.pic.titleLabel.text = [self.pic.titleLabel.text substringToIndex:dotLoc + 3];
            }
        }
    } else {
        self.pic.titleLabel.text = @"暂无报价";
    }
    
    [self.pic setTitle:[NSString stringWithFormat:@"￥%f",model.price] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
