

//
//  YDMyselfTableViewCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDMyselfTableViewCell.h"

@implementation YDMyselfTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        
        CGFloat arrawW = 10 ;
        CGFloat arrawH = 18 ;
        CGFloat arrawY = (self.frame.size.height - arrawH )/2.0f ;
        CGFloat arrawRightRange = 15 + arrawW  ;
        CGFloat arrawX = kScreenWidth - arrawRightRange ;
        CGRect rect = CGRectMake(arrawX, arrawY, arrawW, arrawH);
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:rect] ;
        imageView.image = [UIImage imageNamed:@"homepage_area_more@3x.png"];
        imageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:imageView] ;
        
        self.textLabel.textColor = kColor(133, 133, 133);
        self.textLabel.font = [UIFont systemFontOfSize:16] ;
        

        
        
    }
    return self ;
}





@end
