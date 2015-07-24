//
//  YDDrugDetailsSectionHeaderView.m
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height
#import "YDDrugDetailsSectionHeaderView.h"

@interface YDDrugDetailsSectionHeaderView ()

@property (nonatomic, strong) UIView *back;
@property (nonatomic, strong) UIButton *button;

@end

@implementation YDDrugDetailsSectionHeaderView

- (NSMutableArray *)uiarr {
    if (_uiarr == nil) {
        _uiarr = [NSMutableArray array];
    }
    return _uiarr;
}

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"header";
    YDDrugDetailsSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[YDDrugDetailsSectionHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        NSArray *title = @[@"价格", @"用药点评", @"用药咨询", @"说明书"];
        
        self.back = [[UIView alloc] init];
        self.back.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        [self.contentView addSubview:_back];
        
        for (int i=0; i<4; i++) {
            
            self.button = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            self.button.tag = 1000 + i;
            self.button.frame = CGRectMake(SCREEN_WIDTH / 4 * i, 0, SCREEN_WIDTH / 4, 30);
            [self.button setTitle:title[i] forState:UIControlStateNormal];
            [self.back addSubview:_button];
            
            self.line = [[UIView alloc] init];
            self.line.frame = CGRectMake(SCREEN_WIDTH / 4 * i, self.button.frame.origin.y + self.button.frame.size.height - 2, SCREEN_WIDTH / 4, 2);
            self.line.backgroundColor = [UIColor blueColor];
            self.line.hidden = YES;
            [self.contentView addSubview:_line];
            if (i == 0) {
                self.line.hidden = NO;
            }
            
            NSMutableArray *temp = [NSMutableArray array];
            [temp addObject:self.button];
            [temp addObject:self.line];
            
            [self.uiarr addObject:temp];
        }
    }
    return self;
}

- (void)setHidenWith:(NSInteger)index {
    
    UIView *l = [self.uiarr[index] lastObject];
    l.hidden = NO;
    
}

@end
