//
//  YDInstructionsCell.m
//  text
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDInstructionsCell.h"
#import "YDConst.h"

@interface YDInstructionsCell ()
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *desc;
@end

@implementation YDInstructionsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.contentView.backgroundColor = YDGlobalBg;
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.title = [[UILabel alloc] init];
        self.title.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_title];
        
        self.title.frame = CGRectMake(5, 5, SCREEN_WIDTH - 10, 20);
//        self.title.backgroundColor = [UIColor redColor];
        
        self.desc = [[UILabel alloc] init];
        [self.contentView addSubview:_desc];
        self.desc.numberOfLines = 0;
        self.desc.font = [UIFont systemFontOfSize:12];
        
        self.desc.frame = CGRectMake(5, 25, SCREEN_WIDTH - 10, 20);
//        self.desc.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)cellsetModelInfo:(NSString *)info index:(NSIndexPath *)index {

    NSArray *title = @[@"【药品名称】",@"【成份】",@"【性状】",@"【适应症】",@"【规格】",@"【用法用量】",@"【不良反应】",@"【禁忌】",@"【注意事项】",@"【妊娠与哺乳期用药】",@"【儿童用药】",@"【老人用药】",@"【药物相互作用】",@"【药理作用】",@"【贮藏】",@"【有效期】",@"【批准文号】",@"【执行标准】",@"【说明书修订日期】",@"【生产企业】"];

    if (info.length == 0) {
        self.title.text = @"";
    } else {
        self.title.text = title[index.row];
    }
    self.desc.text = info;
    
    //计算介绍label的高度
    CGRect bounds=[self.desc.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 10, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
    
    self.desc.numberOfLines = 0;
    
    self.desc.font=[UIFont systemFontOfSize:12];

    self.desc.frame = CGRectMake(10, 25, SCREEN_WIDTH - 10, bounds.size.height + 5);
}

+ (CGFloat)heightForCell:(NSString *)info
{
    CGRect bounds=[info boundingRectWithSize:CGSizeMake(SCREEN_WIDTH / 1.2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName] context:nil];
    
    return 5 + 20 + bounds.size.height + 8;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
