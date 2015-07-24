//
//  LifeTipsViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "LifeTipsViewController.h"
#import "LifeTipsModel.h"
#import "LIfeTipsTableViewCell.h"
#import "LifeTipsDetailViewController.h"
#import "OrderPlayView.h"

#define LifeTipsURL @"http://iapi.ipadown.com/api/yangshen/index.api.php?siteid=6&catename=%E5%BF%83%E7%90%86%E5%81%A5%E5%BA%B7"

@interface LifeTipsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *modelArray;

@property(nonatomic,strong)NSMutableArray *titleArray;

@property(nonatomic,strong)NSMutableArray *imageArray;

@end

@implementation LifeTipsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestDataOfLifeTipsWithURL];
    
    self.navigationItem.title = @"心灵鸡汤";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 85) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[LIfeTipsTableViewCell class] forCellReuseIdentifier:@"lifeTipsCell"];
    
    self.imageArray = [@[[UIImage imageNamed:@"lunbo1.jpg"],[UIImage imageNamed:@"lunbo2.jpg"],[UIImage imageNamed:@"lunbo3.jpg"],[UIImage imageNamed:@"lunbo4.jpg"]] mutableCopy];
    
    OrderPlayView *orderPlay = [[OrderPlayView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)] ;
    self.tableView.tableHeaderView = orderPlay;
    
}

//- (NSMutableArray *)imageArray
//{
//    if (!_imageArray)
//    {
//        _imageArray = [@[[UIImage imageNamed:@"lunbo1.jpg"],[UIImage imageNamed:@"lunbo2.jpg"],[UIImage imageNamed:@"lunbo3.jpg"],[UIImage imageNamed:@"lunbo4.jpg"]] mutableCopy];
//    }
//    return _imageArray;
//}

- (void)requestDataOfLifeTipsWithURL
{
    [LORequestManger GET:LifeTipsURL success:^(id response) {
        NSDictionary *dict = (NSDictionary *)response;
        //[self.modelArray removeAllObjects];
        self.modelArray = [NSMutableArray array];
        self.titleArray = [NSMutableArray array];
        for (NSDictionary *listDict in dict[@"list"])
        {
            NSString *classString = listDict[@"title"];
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *detailDict in listDict[@"list"])
            {
                LifeTipsModel *model = [[LifeTipsModel alloc] init];
                [model setValuesForKeysWithDictionary:detailDict];
                [array addObject:model];
            }
            [self.modelArray addObject:array];
            [self.titleArray addObject:classString];
            NSLog(@"%@",classString);
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.modelArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LIfeTipsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lifeTipsCell" forIndexPath:indexPath];
    LifeTipsModel *model = [self.modelArray[indexPath.section] objectAtIndex:indexPath.row];
    [cell setValueForCellWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = [NSString stringWithFormat:@"   %@",self.titleArray[section]];
    return label;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LifeTipsDetailViewController *lifeTipsDetailVc = [[LifeTipsDetailViewController alloc] init];
    LifeTipsModel *model = [self.modelArray[indexPath.section] objectAtIndex:indexPath.row];
    lifeTipsDetailVc.id = model.ID;
    [self.navigationController pushViewController:lifeTipsDetailVc animated:YES];
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
