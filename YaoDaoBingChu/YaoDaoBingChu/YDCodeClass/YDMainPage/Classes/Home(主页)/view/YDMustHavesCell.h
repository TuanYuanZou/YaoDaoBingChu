//
//  YDMustHavesCell.h
//  YDMainPage
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDMustHavesCell : UITableViewCell

@property (nonatomic, strong) UIButton *must;
@property (nonatomic, strong) UIButton *must2;

+ (instancetype)mustCellWithTableView:(UITableView *)tableView;
@end
