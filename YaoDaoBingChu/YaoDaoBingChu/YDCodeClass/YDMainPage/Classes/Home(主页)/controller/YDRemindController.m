//
//  YDRemindController.m
//  text
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "YDRemindController.h"
#import "YDDoseRemindController.h"
@interface YDRemindController ()

@end

@implementation YDRemindController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"服药提醒";
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    left.image = [UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self backView];
}
- (void)left {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)add {
    YDDoseRemindController *doseRVc = [[YDDoseRemindController alloc] init];
    [self.navigationController pushViewController:doseRVc animated:YES];
}

- (void)backView {
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 90, 10, 61.5, 53.5)];
    image.image = [UIImage imageNamed:@"reminder_no_reminder_line"];
    [self.view addSubview:image];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 35, 100, 70, 70)];
    image2.image = [UIImage imageNamed:@"reminder_no_reminder_time"];
    [self.view addSubview:image2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 65, 180, 130, 50)];
//    label.backgroundColor = [UIColor yellowColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    label.alpha = 0.5;
    label.text = @"没有服药提醒,点加号按\n钮添加一条提醒吧!";
    
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
