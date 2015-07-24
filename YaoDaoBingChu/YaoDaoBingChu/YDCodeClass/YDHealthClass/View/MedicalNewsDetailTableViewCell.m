//
//  MedicalNewsDetailTableViewCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "MedicalNewsDetailTableViewCell.h"

@implementation MedicalNewsDetailTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 200)];
        self.detailLabel.textColor = [UIColor blackColor];
        //self.detailLabel.alpha = 0.2;
        self.detailLabel.font = [UIFont systemFontOfSize:15];
        self.detailLabel.numberOfLines = 0;
        [self.contentView addSubview:self.detailLabel];
    }
    return self;
}

- (void)setValueForCellWithModel:(MedicalNewsDetailModel *)model
{
    NSString *str1 = [model.chanshu stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"<div style='background:transparent; font-size:12px;'>" withString:@""];
    NSString *str3 = [str2 stringByReplacingOccurrencesOfString:@"</strong><br />" withString:@""];
    NSString *str4 = [str3 stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    NSString *str5 = [str4 stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    NSString *str6 = [str5 stringByReplacingOccurrencesOfString:@"&nbsp;</div>" withString:@""];
    NSString *str7 = [str6 stringByReplacingOccurrencesOfString:@"</div>" withString:@""];
    NSString *str8 = [str7 stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    NSString *str9 = [str8 stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    
    model.chanshu = str9;
    
    self.detailLabel.text = str9;
    CGRect bounds = [model.chanshu boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];
    self.detailLabel.frame = CGRectMake(15, 0, kScreenWidth - 30, bounds.size.height);
}

+ (CGFloat)heightForCellWithModel:(MedicalNewsDetailModel *)model
{
    CGRect bounds = [model.chanshu boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];
    return bounds.size.height + 5;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
