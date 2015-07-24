//
//  YDSectionHeaderView.m
//  YDMainPage
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDSectionHeaderView.h"

@interface YDSectionHeaderView ()


@property (nonatomic, strong) UIImageView *inImage;
@property (nonatomic, strong) UIImageView *lineImage;

@end

@implementation YDSectionHeaderView

+ (instancetype)headerViewWith:(UITableView *)tableView {
    static NSString *Header = @"Header";
    YDSectionHeaderView *durgsHeaderView = [tableView dequeueReusableCellWithIdentifier:Header];
    if (durgsHeaderView == nil) {
        durgsHeaderView = [[YDSectionHeaderView alloc] initWithReuseIdentifier:Header];
    }
    return durgsHeaderView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBtn.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_backBtn];
        
        self.durgsLabel = [[UILabel alloc] init];
        self.durgsLabel.text = @"感冒用药";
        self.durgsLabel.font = [UIFont systemFontOfSize:15];
//        self.durgsLabel.backgroundColor = [UIColor greenColor];
        [self.backBtn addSubview:_durgsLabel];
        
        self.inImage = [[UIImageView alloc] init];
        self.inImage.image = [UIImage imageNamed:@"homepage_area_more"];
//        self.inImage.backgroundColor = [UIColor grayColor];
        [self.backBtn addSubview:_inImage];
        
        self.lineImage = [[UIImageView alloc] init];
        self.lineImage.image = [UIImage imageNamed:@"home_page_navi_bg"];
//        [self.backBtn addSubview:_lineImage];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height - 1);
    self.durgsLabel.frame = CGRectMake(self.backBtn.frame.origin.x + 5, self.backBtn.frame.origin.y + 5, 70, 20);
    self.inImage.frame = CGRectMake(SCREEN_WIDTH / 1.08, self.backBtn.frame.origin.y + 5, 8, 20);
    self.lineImage.frame = CGRectMake(0, self.backBtn.frame.origin.y + self.backBtn.frame.size.height, self.frame.size.width, 1);
}
- (void)steText:(NSString *)text {
    self.durgsLabel.text = text;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
