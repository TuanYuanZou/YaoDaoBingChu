//
//  DrugFlashViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "DrugFlashViewController.h"
#import "DrugFlashModel.h"
#import "DrugFlashTableViewCell.h"
#import "DrugFlashMorePicTableViewCell.h"
#import "OrderPlayModel.h"
#import "DrugFlashDetaiViewController.h"
#import "UIImageView+WebCache.h"
#import "ImagePlayerView.h"
#import "MJRefresh.h"

#define DrugFlashURL @"http://community.111.com.cn/Api/CommunityV1_4/Articles/list"

@interface DrugFlashViewController ()<UITableViewDataSource,UITableViewDelegate,ImagePlayerViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *modelArray;

@property(nonatomic,strong)ImagePlayerView *imagePlayerView;

@property(nonatomic,strong)NSMutableArray *lunboArray;

@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation DrugFlashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestDataOfDrugFlash];
    
    self.navigationController.navigationBar.translucent = YES;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 30 - 50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[DrugFlashTableViewCell class] forCellReuseIdentifier:@"drugFlash"];
    [self.tableView registerClass:[DrugFlashMorePicTableViewCell class] forCellReuseIdentifier:@"morePic"];
    
//    BackImageView *backImageView = [[BackImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) image:@"view.jpg"];
//    self.tableView.backgroundView = backImageView;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
}

- (void)headerRefreshing
{
    [self requestDataOfDrugFlash];
    [self.tableView.header endRefreshing];
}

- (void)footerRefreshing
{
    [self.tableView.footer endRefreshing];
}

#pragma mark --->>>>>>>>>>>>>>>>>>>>> 运用第三方 实现滚动效果 (imagePlayerView)

- (void)addHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 165)];
    
    //必须给定frame 不然不会显示
    self.imagePlayerView = [[ImagePlayerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 165)];
    [self.imagePlayerView initWithCount:self.lunboArray.count delegate:self];
    self.imagePlayerView.scrollInterval = 2.0f;
    
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomRight;//pangeControl显示位置
    self.imagePlayerView.hidePageControl = NO;//是否隐藏pangeConrol
    [headerView addSubview:_imagePlayerView];
    
    self.tableView.tableHeaderView =headerView;
}

#pragma mark ------->>>> imagePlayer第三方的俩个代理方法

//给定图片
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    [imageView setImageWithURL:[NSURL URLWithString:[self.lunboArray[index] imageUrl]] placeholderImage:nil];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 135, 230, 20)];
    view.backgroundColor = [UIColor grayColor];
    view.alpha = 0.5;
    [imageView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 135, 250, 20)];
    //label.shadowColor = [UIColor grayColor];
    //label.shadowOffset = CGSizeMake(2, 2);
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.text = [self.lunboArray[index] title];
    [imageView addSubview:label];

}

//点击触发事件
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    DrugFlashDetaiViewController *drugFlashVc = [[DrugFlashDetaiViewController alloc] init];
    OrderPlayModel *model = self.lunboArray[index];
    drugFlashVc.id = [model.url substringFromIndex:61];
    //NSLog(@"%@",drugFlashVc.id);
    [self.navigationController pushViewController:drugFlashVc animated:YES];
}

- (NSMutableArray *)modelArray
{
    if (!_modelArray)
    {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (NSMutableArray *)lunboArray
{
    if (!_lunboArray)
    {
        _lunboArray = [NSMutableArray array];
    }
    return _lunboArray;
}

- (void)requestDataOfDrugFlash
{
     [self.lunboArray removeAllObjects];

    [LORequestManger GET:DrugFlashURL success:^(id response) {
        NSDictionary *dict = (NSDictionary *)response;
        for (NSDictionary *lunboDict in [dict[@"data"] objectForKey:@"bannerList"])
        {
            OrderPlayModel *model = [[OrderPlayModel alloc] init];
            [model setValuesForKeysWithDictionary:lunboDict];
            [self.lunboArray addObject:model];
        }
        for (NSDictionary *drugFlashDict in [dict[@"data"] objectForKey:@"info"])
        {
            DrugFlashModel *drugFlashModel = [[DrugFlashModel alloc] init];
            [drugFlashModel setValuesForKeysWithDictionary:drugFlashDict];
            [self.modelArray addObject:drugFlashModel];
        }
        [self.tableView reloadData];
        [self addHeaderView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DrugFlashModel *model =  _modelArray[indexPath.row];

    if (model.attachment.count == 1)
    {
        DrugFlashTableViewCell *drugFlashCell = [tableView dequeueReusableCellWithIdentifier:@"drugFlash" forIndexPath:indexPath];
        [drugFlashCell setDataForCell:model];
        drugFlashCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [drugFlashCell.selectButton addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
        drugFlashCell.tag = 100 + indexPath.row;
        if (model.isSelect == YES)
        {
            [drugFlashCell setDataForCell:model];
        }
        else
        {
            [drugFlashCell setDataForCell:model];
        }
        return drugFlashCell;
    }
    else
    {
        DrugFlashMorePicTableViewCell *morePicCell = [tableView dequeueReusableCellWithIdentifier:@"morePic" forIndexPath:indexPath];
        [morePicCell setValueForCellWithModel:model];
        morePicCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [morePicCell.selectButton addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
        morePicCell.tag = 1000 + indexPath.row;
        if (model.isSelect == YES)
        {
            [morePicCell setValueForCellWithModel:model];
        }
        else
        {
            [morePicCell setValueForCellWithModel:model];
        }
        return morePicCell;
    }
}

- (void)buttonAction1:(UIButton *)button
{
    DrugFlashModel *model = self.modelArray[button.superview.superview.tag - 100];
    if (model.isSelect == YES)
    {
        model.isSelect = NO;
        
        NSArray *indexArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:button.superview.superview.tag - 100 inSection:0]];
        [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        model.isSelect = YES;
        
        NSArray *indexArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:button.superview.superview.tag - 100 inSection:0]];
        [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)buttonAction2:(UIButton *)button
{
    DrugFlashModel *model = self.modelArray[button.superview.superview.tag - 1000];
    if (model.isSelect == YES)
    {
        model.isSelect = NO;
        
        NSArray *indexArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:button.superview.superview.tag - 1000 inSection:0]];
        [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        model.isSelect = YES;
        
        NSArray *indexArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:button.superview.superview.tag - 1000 inSection:0]];
        [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DrugFlashModel *model =  _modelArray[indexPath.row];
    if (model.attachment.count == 1)
    {
        if (model.isSelect == YES)
        {
            return [DrugFlashTableViewCell heightForCell:model];
        }
        else
        {
            return [DrugFlashTableViewCell heightForCell:model];
        }
    }
    else
    {
        if (model.isSelect == YES)
        {
            return [DrugFlashMorePicTableViewCell heightForCell:model];
        }
        else
        {
            return [DrugFlashMorePicTableViewCell heightForCell:model];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DrugFlashModel *model = _modelArray[indexPath.row];
    DrugFlashDetaiViewController *drugFlashDetailVc = [[DrugFlashDetaiViewController alloc] init];
    drugFlashDetailVc.id = [NSString stringWithFormat:@"%@",model.articleId];
    [self.navigationController pushViewController:drugFlashDetailVc animated:YES];
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
