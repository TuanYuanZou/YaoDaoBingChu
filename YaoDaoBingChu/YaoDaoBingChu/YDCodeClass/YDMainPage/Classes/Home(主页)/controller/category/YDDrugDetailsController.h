//
//  YDDrugDetailsController.h
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDPartnerDetailModel.h"
@interface YDDrugDetailsController : UITableViewController

@property (nonatomic, strong) YDPartnerDetailModel *model;

@property (nonatomic, copy) NSString * barcode;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * name;


@property (nonatomic, copy) NSString * durgId;
@end
