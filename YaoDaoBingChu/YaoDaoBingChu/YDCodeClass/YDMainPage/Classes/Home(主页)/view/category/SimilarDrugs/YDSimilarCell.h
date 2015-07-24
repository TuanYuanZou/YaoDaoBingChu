//
//  YDSimilarCell.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDSimilarCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *uiarr;

- (void)cellSetModel:(NSMutableArray *)model;

- (void)setBtnTarget:(id)target action:(SEL)action;
@end
