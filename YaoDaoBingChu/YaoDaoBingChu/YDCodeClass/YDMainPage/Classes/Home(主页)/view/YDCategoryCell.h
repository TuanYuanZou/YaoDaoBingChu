//
//  YDCategoryCell.h
//  YDMainPage
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDCategoryCell : UITableViewCell

@property (nonatomic, strong) UIButton *scan; //扫码

@property (nonatomic, strong) UIButton *advisory; //咨询

@property (nonatomic, strong) UIButton *dose; //服药

@property (nonatomic, strong) UIButton *drug; //找药


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
