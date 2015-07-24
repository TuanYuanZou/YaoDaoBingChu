//
//  YDCategoryCell.m
//  YDMainPage
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDCategoryCell.h"

@interface YDCategoryCell ()

//@property (nonatomic, strong) UIButton *scan; //扫码
@property (nonatomic, strong) UILabel *scanLabel;

//@property (nonatomic, strong) UIButton *advisory; //咨询
@property (nonatomic, strong) UILabel *advisoryLabel;

//@property (nonatomic, strong) UIButton *dose; //服药
@property (nonatomic, strong) UILabel *doseLabel;

//@property (nonatomic, strong) UIButton *drug; //找药
@property (nonatomic, strong) UILabel *drugLabel;
@end

@implementation YDCategoryCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"category";
    YDCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YDCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.scan = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scan setImage:[UIImage imageNamed:@"homepage_menu_scan"] forState:UIControlStateNormal];
//        self.scan.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_scan];
        
        self.scanLabel = [[UILabel alloc] init];
        self.scanLabel.text = @"扫码找药";
        self.scanLabel.font = [UIFont systemFontOfSize:11];
//        self.scanLabel.backgroundColor = [UIColor purpleColor];
        self.scanLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_scanLabel];
        
        self.advisory = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.advisory setImage:[UIImage imageNamed:@"homepage_menu_askdoctor"] forState:UIControlStateNormal];
//        self.advisory.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_advisory];
        
        self.advisoryLabel = [[UILabel alloc] init];
        self.advisoryLabel.text = @"咨询医生";
        self.advisoryLabel.font = [UIFont systemFontOfSize:11];
//        self.advisoryLabel.backgroundColor = [UIColor purpleColor];
        self.advisoryLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_advisoryLabel];
        
        self.dose = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.dose setImage:[UIImage imageNamed:@"homepage_menu_remind"] forState:UIControlStateNormal];
//        self.dose.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_dose];
        
        self.doseLabel = [[UILabel alloc] init];
        self.doseLabel.text = @"服药提醒";
        self.doseLabel.font = [UIFont systemFontOfSize:11];
//        self.doseLabel.backgroundColor = [UIColor purpleColor];
        self.doseLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_doseLabel];
        
        self.drug = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.drug setImage:[UIImage imageNamed:@"homepage_menu_finddrug"] forState:UIControlStateNormal];
//        self.drug.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_drug];
        
        self.drugLabel = [[UILabel alloc] init];
        self.drugLabel.text = @"对症找药";
        self.drugLabel.font = [UIFont systemFontOfSize:11];
//        self.drugLabel.backgroundColor = [UIColor purpleColor];
        self.drugLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_drugLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scan.frame = CGRectMake(((SCREEN_WIDTH - 200) / 4) / 2, 10, 50, 50);
    self.scan.layer.masksToBounds = YES;
    self.scan.layer.cornerRadius = self.scan.frame.size.width / 2;
//    self.scan.layer.borderWidth = 1;
    self.scanLabel.frame = CGRectMake(self.scan.frame.origin.x, self.scan.frame.origin.y + self.scan.frame.size.height, self.scan.frame.size.width, 20);
    
    
    self.advisory.frame = CGRectMake(self.scan.frame.origin.x + self.scan.frame.size.width + ((SCREEN_WIDTH - 200) / 4), 10, 50, 50);
    self.advisory.layer.masksToBounds = YES;
    self.advisory.layer.cornerRadius = self.advisory.frame.size.width / 2;
//    self.advisory.layer.borderWidth = 1;
    self.advisoryLabel.frame = CGRectMake(self.advisory.frame.origin.x, self.advisory.frame.origin.y + self.advisory.frame.size.height, self.advisory.frame.size.width, 20);
    
    self.dose.frame = CGRectMake(self.advisory.frame.origin.x + self.advisory.frame.size.width + ((SCREEN_WIDTH - 200) / 4), 10, 50, 50);
    self.dose.layer.masksToBounds = YES;
    self.dose.layer.cornerRadius = self.dose.frame.size.width / 2;
//    self.dose.layer.borderWidth = 1;
    self.doseLabel.frame = CGRectMake(self.dose.frame.origin.x, self.dose.frame.origin.y + self.dose.frame.size.height, self.dose.frame.size.width, 20);
    
    self.drug.frame = CGRectMake(self.dose.frame.origin.x + self.dose.frame.size.width + ((SCREEN_WIDTH - 200) / 4), 10, 50, 50);
    
    self.drug.layer.masksToBounds = YES;
    self.drug.layer.cornerRadius = self.drug.frame.size.width / 2;
//    self.drug.layer.borderWidth = 1;
    self.drugLabel.frame = CGRectMake(self.drug.frame.origin.x, self.drug.frame.origin.y + self.drug.frame.size.height, self.scan.frame.size.width, 20);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
