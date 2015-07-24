//
//  YDDurgsCell.h
//  YDMainPage
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDDurgsCell : UITableViewCell
@property (nonatomic, strong) NSArray *temp;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) NSMutableArray *uiArr;

+ (instancetype)drugsCellWithTableView:(UITableView *)tableView;
@end
