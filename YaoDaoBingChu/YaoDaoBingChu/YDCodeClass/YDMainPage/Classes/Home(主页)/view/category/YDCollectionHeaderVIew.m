//
//  YDCollectionHeaderVIew.m
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDCollectionHeaderVIew.h"

@interface YDCollectionHeaderVIew ()
@property (nonatomic, strong) UIView *back;
@property (nonatomic, strong) UIView *line;




@end

@implementation YDCollectionHeaderVIew

- (NSMutableArray *)uiarr {
    if (_uiarr == nil) {
        _uiarr = [NSMutableArray array];
    }
    return _uiarr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        self.back.backgroundColor = [UIColor whiteColor];
        [self addSubview:_back];
        
        NSArray *array = @[@"品牌", @"价格", @"医保", @"基本药"];
        for (int i=0; i<4; i++) {
            self.button = [UIButton buttonWithType:UIButtonTypeCustom];
            self.button.tag = 100 + i;
            self.button.frame = CGRectMake(self.back.frame.size.width / 4 * i, 0, self.back.frame.size.width / 4, self.back.frame.size.height);
//            self.back.backgroundColor = [UIColor grayColor];
            [self.back addSubview:_button];
            
            self.label = [[UILabel alloc] init];
            [self.back addSubview:_label];
            self.label.text = array[i];
            self.label.textAlignment = NSTextAlignmentCenter;
            self.label.font = [UIFont systemFontOfSize:12];
            self.label.frame = CGRectMake(self.button.frame.origin.x + 5, 14, 55, 20);
//            self.label.backgroundColor = [UIColor blueColor];
            
            
            self.image = [[UIImageView alloc] init];
            self.image.frame = CGRectMake(self.label.frame.origin.x + self.label.frame.size.width + 5, 21, 10, 5);
            self.image.image = [UIImage imageNamed:@"buddy_header_arrow"];
            [self.back addSubview:_image];
            
            self.line = [[UIView alloc] init];
            self.line.frame = CGRectMake(self.button.frame.origin.x + self.button.frame.size.width, 14, 1, 22);
            self.line.backgroundColor = [UIColor blackColor];
            [self.back addSubview:_line];
            
            
            
            NSMutableArray *temp = [NSMutableArray array];
            [temp addObject:_button];
            [temp addObject:_label];
            [temp addObject:_image];
            
            [self.uiarr addObject:temp];
        }
    }
    return self;
}

@end
