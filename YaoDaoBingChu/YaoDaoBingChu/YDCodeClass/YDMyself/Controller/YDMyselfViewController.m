//
//  YDMyselfViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDMyselfViewController.h"
#import "YDMessageViewController.h"

#import "YDMyselfTableViewCell.h"

#import "YDMyselfTableViewHeaderView.h"

#import "YDMessageShowViewController.h"

@interface YDMyselfViewController ()<UITableViewDataSource,UITableViewDelegate>

//  cell上主题数据源
@property(nonatomic,strong)NSArray * cellTitleDataArray ;
//  cell上图片数据源
@property(nonatomic,strong)NSArray * cellImageDataArray ;



@end

@implementation YDMyselfViewController
#pragma 懒加载
- (NSArray *)cellTitleDataArray
{
    if (!_cellTitleDataArray) {
        _cellTitleDataArray = @[@[@"服药提醒",@"我的咨询",@"我的留言"],@[@"我的收藏",@"账户设置"],@[@"关于我们"]] ;
    }
    return _cellTitleDataArray ;
}

- (NSArray *)cellImageDataArray
{
    if (!_cellImageDataArray) {
        _cellImageDataArray = @[@[@"mine_drug_remind@3x.png",@"mine_consultation@3x.png",@"mine_comment@3x.png"],@[@"mine_collection@3x.png",@"mine_account_set@3x.png"],@[@"mine_about_ypt@3x.png"]] ;
    }
    return _cellImageDataArray ;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat tableViewY = 0;
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, tableViewY, kScreenWidth, kScreenHeight - tableViewY) style:UITableViewStylePlain] ;
    tableView.delegate = self ;
    tableView.dataSource = self ;
    self.navigationController.navigationBar.translucent = NO ;
    //  设置导航栏的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    //  去除多余cell的分割线
    [self setExtraCellLineHidden:tableView] ;
    [self.view addSubview:tableView] ;
    
    //  “留言”按钮
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(message)] ;
    self.navigationItem.rightBarButtonItem = rightBarButton ;
    
}


//  每一个分区cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = self.cellImageDataArray[section] ;
    return array.count ;
}


//  分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellImageDataArray.count ;
}


//  返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellItentifier = @"cell" ;
    //  注册
    [tableView registerClass:[YDMyselfTableViewCell class] forCellReuseIdentifier:cellItentifier] ;
    YDMyselfTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellItentifier forIndexPath:indexPath] ;
    
   
    NSArray * titleArray = self.cellTitleDataArray[indexPath.section];
    NSArray * imageArray = self.cellImageDataArray[indexPath.section];
    cell.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]] ;
    cell.textLabel.text = titleArray[indexPath.row] ;
    return cell ;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 200 ;
    }
    else
    {
        return 20 ;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [[YDMyselfTableViewHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)] ;
    }
    return nil ;
}

#pragma mark - 选中某一个cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 2) {
       //  跳转到我的留言界面
        YDMessageShowViewController * messageShowVc = [[YDMessageShowViewController alloc]init] ;
        [self.navigationController pushViewController:messageShowVc animated:YES] ;
    }
}



#pragma mark - 去除多余cell的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}



#pragma mark - 添加留言
- (void)message
{
    YDMessageViewController * messageVc = [[YDMessageViewController alloc]init] ;
    [self.navigationController pushViewController:messageVc animated:YES] ;
    
}

@end
