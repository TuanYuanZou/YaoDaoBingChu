//
//  YDDoseRemindController.m
//  text
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "YDDoseRemindController.h"

@interface YDDoseRemindController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *drugName;
@property (weak, nonatomic) IBOutlet UITextField *remark;

@end

@implementation YDDoseRemindController
- (IBAction)Interval {
}
- (IBAction)time {
}
- (IBAction)date {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服药提醒";
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    left.image = [UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(right)];
    self.navigationItem.rightBarButtonItem = right;
}
- (void)left {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)right {
    NSLog(@"完成");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
