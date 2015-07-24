//
//  YDSectionHeaderView.h
//  YDMainPage
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *durgsLabel;

- (void)steText:(NSString *)text;
+ (instancetype)headerViewWith:(UITableView *)tableView;
@end
