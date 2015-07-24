//
//  YDMustHavesCell.m
//  YDMainPage
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDMustHavesCell.h"

@interface YDMustHavesCell ()
@property (nonatomic, strong) UIImageView *lineImage;
@end

@implementation YDMustHavesCell

+ (instancetype)mustCellWithTableView:(UITableView *)tableView {
    static NSString *Must = @"mustHave";
    YDMustHavesCell *mustCell = [tableView dequeueReusableCellWithIdentifier:Must];
    if (mustCell == nil) {
        mustCell = [[YDMustHavesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Must];
    }
    return mustCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.must = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.must.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_must];
        
        
        self.lineImage = [[UIImageView alloc] init];
        [self.lineImage setImage:[UIImage imageNamed:@"dotline"]];
//        [self.contentView addSubview:_lineImage];
        

        self.must2 = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.must2.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_must2];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.must.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 1) / 2, self.frame.size.height);
    
    self.lineImage.frame = CGRectMake(self.must.frame.origin.x + self.must.frame.size.width, 0, 1, self.frame.size.height);
    
    self.must2.frame = CGRectMake(self.lineImage.frame.origin.x + self.lineImage.frame.size.width, 0, (SCREEN_WIDTH - 1) / 2, self.frame.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
