//
//  YDDrugDetailsSectionHeaderView.h
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDDrugDetailsSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) NSMutableArray *uiarr;
@property (nonatomic, strong) UIView *line;
- (void)setHidenWith:(NSInteger)index;
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
