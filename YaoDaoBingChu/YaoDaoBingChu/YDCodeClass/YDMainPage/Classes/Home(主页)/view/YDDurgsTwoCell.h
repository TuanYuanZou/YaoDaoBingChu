//
//  YDDurgsTwoCell.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDDurgsTwoCell : UITableViewCell
@property (nonatomic, strong) NSArray *temp;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) NSMutableArray *addui;

+ (instancetype)drugsCellWithTableView:(UITableView *)tableView;
@end
