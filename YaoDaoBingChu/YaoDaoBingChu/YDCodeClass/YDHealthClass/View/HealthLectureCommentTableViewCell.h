//
//  HealthLectureCommentTableViewCell.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthLectureCommentModel.h"

@interface HealthLectureCommentTableViewCell : UITableViewCell//<UITableViewDataSource,UITableViewDelegate>

//@property(nonatomic,strong)UIScrollView *scrollView;
//
//@property(nonatomic,strong)UITableView *commentTableView;
//
//@property(nonatomic,strong)UITableView *recommendTableView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *commentLabel;

- (void)setValueForCellWithModel:(HealthLectureCommentModel *)model;

+ (CGFloat)heightForCell:(HealthLectureCommentModel *)model;

@end
