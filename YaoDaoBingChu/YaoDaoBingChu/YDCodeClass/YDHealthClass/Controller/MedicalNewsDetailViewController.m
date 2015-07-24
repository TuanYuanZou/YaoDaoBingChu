//
//  MedicalNewsDetailViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "MedicalNewsDetailViewController.h"
#import "MedicalNewsDetailTableViewCell.h"
#import "MedicalNewsDetailModel.h"
#import "UIImageView+WebCache.h"

#define MedicalNewsDetailURL @"http://m.jkepd.com/shipinjson.php?ac=info&t=2&id="

@interface MedicalNewsDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)MedicalNewsDetailModel *model;

@end

@implementation MedicalNewsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requsetDataOfMedicalNewsDetailWithURL];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 215 + 20, kScreenWidth, kScreenHeight - 215 - 64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //self.tableView.backgroundColor = [UIColor blueColor];
    
    self.navigationItem.title = @"生活贴士";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[MedicalNewsDetailTableViewCell class] forCellReuseIdentifier:@"medicalNewsCell"];
}

- (void)requsetDataOfMedicalNewsDetailWithURL
{
    [LORequestManger GET:[MedicalNewsDetailURL stringByAppendingString:_id] success:^(id response) {
        NSDictionary *dict = (NSDictionary *)response;
        NSDictionary *categorysDict = dict[@"categorys"];
        self.model = [[MedicalNewsDetailModel alloc] init];
        [self.model setValuesForKeysWithDictionary:categorysDict];
        //NSLog(@"%@",self.model.chanshu);
        [self.tableView reloadData];
        [self setHeader];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setHeader
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 215)];
    headerView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    [self.view addSubview:headerView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
    titleLabel.text = self.model.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:titleLabel];
    
    UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth - 20, 180)];
    [picImageView sd_setImageWithURL:[NSURL URLWithString:self.model.imgurl] placeholderImage:[UIImage imageNamed:@"shengbing.jpg"] completed:nil];
    [headerView addSubview:picImageView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 220, kScreenWidth, 1)];
    lineView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:lineView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalNewsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"medicalNewsCell" forIndexPath:indexPath];
    [cell setValueForCellWithModel:self.model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MedicalNewsDetailTableViewCell heightForCellWithModel:self.model];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
