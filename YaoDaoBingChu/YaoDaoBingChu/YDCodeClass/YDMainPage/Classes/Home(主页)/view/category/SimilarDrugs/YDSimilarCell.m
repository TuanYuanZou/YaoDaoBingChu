//
//  YDSimilarCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDSimilarCell.h"
#import "YDPriceModel.h"
#import "UIImageView+AFNetworking.h"
@interface YDSimilarCell ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *picLabel;


@end

@implementation YDSimilarCell
- (NSMutableArray *)uiarr {
    if (_uiarr == nil) {
        _uiarr = [NSMutableArray array];
    }
    return _uiarr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        for (int i=0; i<3; i++) {
            self.button = [UIButton buttonWithType:UIButtonTypeCustom];
            self.button.frame = CGRectMake(SCREEN_WIDTH / 3 * i, 0, SCREEN_WIDTH / 3, SCREEN_WIDTH / 3);
            [self.contentView addSubview:_button];
            self.button.tag = 111 + i;
//            self.button.backgroundColor = [UIColor redColor];
            
            self.image = [[UIImageView alloc] init];
            self.image.frame = CGRectMake(0, 0, SCREEN_WIDTH / 3, SCREEN_WIDTH / 3 - 50);
            [self.button addSubview:_image];
//            self.image.backgroundColor = [UIColor grayColor];
            
            self.label = [[UILabel alloc] init];
            self.label.frame = CGRectMake(0, SCREEN_WIDTH / 3 - 50, SCREEN_WIDTH / 3, 25);
            [self.button addSubview:_label];
            self.label.textAlignment = NSTextAlignmentCenter;
            self.label.font = [UIFont systemFontOfSize:12];
//            self.label.backgroundColor = [UIColor greenColor];
            
            self.picLabel = [[UILabel alloc] init];
            self.picLabel.frame = CGRectMake(0, SCREEN_WIDTH / 3 - 25, SCREEN_WIDTH / 3, 25);
            [self.button addSubview:_picLabel];
//            self.picLabel.backgroundColor = [UIColor orangeColor];
            self.picLabel.textAlignment = NSTextAlignmentCenter;
            self.picLabel.font = [UIFont systemFontOfSize:12];
            self.picLabel.textColor = [UIColor redColor];
            
            NSMutableArray *temp = [NSMutableArray array];
            [temp addObject:_button];
            [temp addObject:_image];
            [temp addObject:_label];
            [temp addObject:_picLabel];
            
            [self.uiarr addObject:temp];
            
        }
        
    }
    return self;
}
- (void)cellSetModel:(NSMutableArray *)model {
    
//    NSLog(@"%@",model);
    for (int i=0; i<model.count; i++) {
        
        NSArray *arr = self.uiarr[i];
        
        YDPriceModel *m = model[i];
        
        UIImageView *im = arr[1];
        NSMutableString *str = [m.titleimg mutableCopy];
        if (![str isEqualToString:@""]) {
            [str insertString:@"n" atIndex:7];
        }
        [im setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"drug_placeholder"]];
        
        UILabel *l = arr[2];
        l.text = m.namecn;
        
        UILabel *p = arr.lastObject;
        
        
        NSString *price = [NSString stringWithFormat:@"%f",m.avgprice];
        if (m.avgprice != 0.0) {
            p.text = [NSString stringWithFormat:@"￥%@",price];
            NSUInteger dotLoc = [p.text rangeOfString:@"."].location;
            if (dotLoc != NSNotFound) {
                // 超过2位小数
                if (p.text.length - dotLoc > 3) {
                    p.text = [p.text substringToIndex:dotLoc + 3];
                }
            }
        } else {
            p.text = @"暂无报价";
        }
    }
}

- (void)setBtnTarget:(id)target action:(SEL)action {
    for (NSArray *arr in self.uiarr) {
        UIButton *button = arr.firstObject;
        
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
