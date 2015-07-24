//
//  YDDrugDetailsHeaderView.m
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDDrugDetailsHeaderView.h"
#import "UIImageView+AFNetworking.h"
@interface YDDrugDetailsHeaderView ()

@property (nonatomic, strong) UIImageView *str;
@property (nonatomic, strong) UIImageView *mark;
@property (nonatomic, strong) NSMutableArray *uiarr;
@end

@implementation YDDrugDetailsHeaderView

- (NSMutableArray *)uiarr {
    if (_uiarr == nil) {
        _uiarr = [NSMutableArray array];
    }
    return _uiarr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.image = [[UIImageView alloc] init];
        self.image.frame = CGRectMake(15, 15, SCREEN_WIDTH / 3.1, SCREEN_WIDTH / 3.1);
//        self.image.backgroundColor = [UIColor redColor];
        [self addSubview:_image];
        
        self.name = [[UILabel alloc] init];
        self.name.frame = CGRectMake(self.image.frame.origin.x + self.image.frame.size.width + 10, 10, SCREEN_WIDTH / 1.8, 25);
        [self addSubview:_name];
//        self.name.text = @"六味地黄丸";
        self.name.font = [UIFont systemFontOfSize:14];
//        self.name.backgroundColor = [UIColor yellowColor];
        
        self.company = [[UILabel alloc] init];
        self.company.frame = CGRectMake(self.image.frame.origin.x + self.image.frame.size.width + 10, self.name.frame.origin.y + self.name.frame.size.height + 5, SCREEN_WIDTH / 1.8, 25);
        [self addSubview:_company];
//        self.company.text = @"六味地黄丸就发了卡数据的徕卡是";
        self.company.font = [UIFont systemFontOfSize:12];
//        self.company.backgroundColor = [UIColor greenColor];
        
        self.desc = [[UILabel alloc] init];
         self.desc.frame = CGRectMake(self.image.frame.origin.x + self.image.frame.size.width + 10, self.company.frame.origin.y + self.company.frame.size.height + 5, SCREEN_WIDTH / 1.8, 40);
        [self addSubview:_desc];
//        self.desc.text = @"六味地黄丸就发了卡数据的徕接啊深刻理解的快乐撒即可将肯定拉数据来看大神卡是";
        self.desc.numberOfLines = 0;
        self.desc.font = [UIFont systemFontOfSize:12];
//        self.desc.backgroundColor = [UIColor grayColor];
        
        for (int i=0; i<5; i++) {
            self.str = [[UIImageView alloc] init];
            self.str.image = [UIImage imageNamed:@"star"];
            self.str.frame = CGRectMake(self.name.frame.origin.x + 20 * i, self.desc.frame.origin.y + self.desc.frame.size.height + 10, 15, 15);
//            self.str.backgroundColor = [UIColor blueColor];
            [self addSubview:_str];
            [self.uiarr addObject:self.str];
        }
        
//        self.collect = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.collect.backgroundColor = [UIColor redColor];
//        self.collect.frame = CGRectMake(SCREEN_WIDTH - 50, self.desc.frame.origin.y + self.desc.frame.size.height + 10, 15, 15);
//        [self.collect setImage:[UIImage imageNamed:@"details_collect_normal"] forState:UIControlStateNormal];
//        [self addSubview:_collect];

        
    }
    return self;
}


- (void)setModel:(YDInstructionsModel *)model {
    self.name.text = model.namecn;
    self.company.text = model.composition;
    self.desc.text = model.gongneng;
    
    NSMutableString *str = [model.titleimg mutableCopy];
    [str insertString:@"n" atIndex:7];
    [self.image setImageWithURL:[NSURL URLWithString:str]];
    
    for (int i=0; i<model.score; i++) {
        
        UIImageView *str = self.uiarr[i];
        str.image = [UIImage imageNamed:@"star_highlighted"];
        
    }
    
}
@end
