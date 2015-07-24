//
//  YDNiMeiDeCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDNiMeiDeCell.h"
#import "UIImageView+AFNetworking.h"

@interface YDNiMeiDeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *nimeideImage;
@property (weak, nonatomic) IBOutlet UILabel *nimeideLabel;

@end
@implementation YDNiMeiDeCell

- (void)setModel:(YDPartnerModel *)model {
    
    NSMutableString *str = [model.titleimg mutableCopy];
    if (![str isEqualToString:@""]) {
        [str insertString:@"n" atIndex:7];
    }
    
    [self.nimeideImage setImageWithURL:[NSURL URLWithString:str]];
    self.nimeideLabel.text = model.namecn;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
