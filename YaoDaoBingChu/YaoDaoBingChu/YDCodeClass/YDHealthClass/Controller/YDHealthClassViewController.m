//
//  YDHealthClassViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDHealthClassViewController.h"
#import "DrugFlashViewController.h"
#import "HealthLectureViewController.h"
#import "MedicalNewsViewController.h"
#import "LifeTipsViewController.h"

@interface YDHealthClassViewController ()//<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)DrugFlashViewController *drugFlashVc;
@property(nonatomic,strong)HealthLectureViewController *healthLectureVc;
@property(nonatomic,strong)MedicalNewsViewController *medicalNewsVc;
@property(nonatomic,strong)LifeTipsViewController *lifeTipsVc;

@property(nonatomic,strong)UIView *myView;

//@property(nonatomic,strong)UITableView *tableView;

@end

@implementation YDHealthClassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self titleArray];
    
    [self setHeaderView];
    
    [self creatSubController];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"view.jpg"] forBarMetrics:UIBarMetricsDefault];
    
}

- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[@"医药快讯",@"百家讲坛",@"健康贴士",@"心灵鸡汤"];
    }
    return _titleArray;
}

- (void)creatSubController
{
    self.healthLectureVc = [[HealthLectureViewController alloc] init];
    [self addChildViewController:_healthLectureVc];
    [self.view addSubview:_healthLectureVc.view];
    //_healthLectureVc.view.backgroundColor = [UIColor cyanColor];
    _healthLectureVc.view.frame = CGRectMake(0, 40, 375, 667);

    self.medicalNewsVc = [[MedicalNewsViewController alloc] init];
    [self addChildViewController:_medicalNewsVc];
    [self.view addSubview:_medicalNewsVc.view];
    _medicalNewsVc.view.frame = CGRectMake(0, 40, 375, 667);
    
    self.lifeTipsVc = [[LifeTipsViewController alloc] init];
    [self addChildViewController:_lifeTipsVc];
    [self.view addSubview:_lifeTipsVc.view];
    _lifeTipsVc.view.frame = CGRectMake(0, 40, 375, 667);
    
    self.drugFlashVc = [[DrugFlashViewController alloc] init];
    [self addChildViewController:_drugFlashVc];
    [self.view addSubview:_drugFlashVc.view];
    _drugFlashVc.view.frame = CGRectMake(0, 40, 375, 667);
}

- (void)setHeaderView
{
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    //self.myView.backgroundColor = [UIColor redColor];
    //[self.myView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"view.jpg"]]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 37, kScreenWidth, 1)];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.5;
    [self.view addSubview:label];
    [self.view addSubview:self.myView];
    for (int i = 0; i < _titleArray.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(4 + kScreenWidth / 4 * i, 4, kScreenWidth / 4 - 8, 30);
        button.tag = 100 + i;
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.myView addSubview:button];
        if (button.tag == 100)
        {
            button.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:192 / 255.0 blue:203 / 255.0 alpha:1];
        }
    }
}

- (void)buttonAction:(UIButton *)button
{
    for (UIButton *click in self.myView.subviews)
    {
        if (click == button)
        {
            click.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:192 / 255.0 blue:203 / 255.0 alpha:1];
        }
        else
        {
            click.backgroundColor = nil;
        }
    }
    switch (button.tag)
    {
        case 100:
            self.drugFlashVc.view.hidden = NO;
            self.healthLectureVc.view.hidden = YES;
            self.medicalNewsVc.view.hidden = YES;
            self.lifeTipsVc.view.hidden = YES;
            break;
        case 101:
            self.drugFlashVc.view.hidden = YES;
            self.healthLectureVc.view.hidden = NO;
            self.medicalNewsVc.view.hidden = YES;
            self.lifeTipsVc.view.hidden = YES;
            break;
        case 102:
            self.drugFlashVc.view.hidden = YES;
            self.healthLectureVc.view.hidden = YES;
            self.medicalNewsVc.view.hidden = NO;
            self.lifeTipsVc.view.hidden = YES;
            break;
        case 103:
            self.drugFlashVc.view.hidden = YES;
            self.healthLectureVc.view.hidden = YES;
            self.medicalNewsVc.view.hidden = YES;
            self.lifeTipsVc.view.hidden = NO;
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
 {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
