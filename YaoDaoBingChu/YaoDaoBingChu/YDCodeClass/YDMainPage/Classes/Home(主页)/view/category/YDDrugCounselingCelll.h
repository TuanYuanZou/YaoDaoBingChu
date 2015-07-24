//
//  YDDrugCounselingCelll.h
//  text
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDDrugCounselingModel.h"
@interface YDDrugCounselingCelll : UITableViewCell


- (void)cellsetModel:(YDDrugCounselingModel *)model;

+ (CGFloat)heightForCell:(YDDrugCounselingModel *)model;
@end
