//
//  HealthLectureDetailViewController.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthLectureModel.h"

@interface HealthLectureDetailViewController : UIViewController

{
    UIView *markLine1;
    UIView *markLine2;
}

@property(nonatomic,strong)HealthLectureModel *model;

@end
