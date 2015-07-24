//
//  YDPartnerCollectionCell.m
//  text
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDPartnerCollectionCell.h"

@interface YDPartnerCollectionCell ()


@end
@implementation YDPartnerCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.back = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.back.backgroundColor = [UIColor greenColor];
//        [self.contentView addSubview:_back];
        
        self.trademark = [[UIImageView alloc] init];
//        self.trademark.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_trademark];
        
        self.name = [[UILabel alloc] init];
        self.name.text = @"云南白药";
        self.name.font = [UIFont systemFontOfSize:14];
        self.name.textAlignment = NSTextAlignmentCenter;
//        self.name.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_name];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.back.frame = CGRectMake(0, 0, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 4.5);
    self.name.frame = CGRectMake(self.back.frame.origin.x, self.back.frame.origin.y + self.back.frame.size.height - 25, self.back.frame.size.width, 20);
    self.trademark.frame = CGRectMake(self.back.frame.origin.x + 5, self.back.frame.origin.y + 5, self.back.frame.size.width - 10, self.back.frame.size.height - 10 - self.name.frame.size.height);
}
@end
