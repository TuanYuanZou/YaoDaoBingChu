//
//  YDInstructionsCell.h
//  text
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDInstructionsModel.h"
@interface YDInstructionsCell : UITableViewCell

- (void)cellsetModelInfo:(NSString *)info index:(NSIndexPath *)index;

+ (CGFloat)heightForCell:(NSString *)info;
@end
