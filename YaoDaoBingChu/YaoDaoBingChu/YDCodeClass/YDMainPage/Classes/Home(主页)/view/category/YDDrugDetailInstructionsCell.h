//
//  YDDrugDetailInstructionsCell.h
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDMedicationReviewsModel.h"
@interface YDDrugDetailInstructionsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)changeImageWith:(YDMedicationReviewsModel *)model;
- (void)cellsetModel:(YDMedicationReviewsModel *)model;
- (void)likeAddTarget:(id)target action:(SEL)action;
+ (CGFloat)heightForCell:(YDMedicationReviewsModel *)model;
@end
