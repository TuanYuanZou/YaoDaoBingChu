//
//  YDPartnerCell.h
//  YDMainPage
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDPartnerCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *uiarr;

@property (nonatomic, strong) UIButton *back;
@property (nonatomic, strong) UIImageView *trademark;
@property (nonatomic, strong) UILabel *name;

+ (instancetype)tradeCellWithTableView:(UITableView *)tableView;
@end
