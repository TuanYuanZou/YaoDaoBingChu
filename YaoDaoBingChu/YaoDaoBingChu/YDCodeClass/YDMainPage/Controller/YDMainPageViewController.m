//
//  YDMainPageViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDMainPageViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

#import "YDCategoryCell.h"
#import "YDMustHavesCell.h"
#import "YDDurgsCell.h"
#import "YDSectionHeaderView.h"
#import "YDPartnerCell.h"
#import "YDUsuallyModel.h"
#import "YDCategoryModel.h"
#import "YDPartnerModel.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "YDPartnerController.h"
#import "YDMustHavesController.h"
#import "MJExtension.h"
#import "YDScanController.h"
#import "YDAdvisoryController.h"
#import "YDRemindController.h"
#import "YDFindController.h"
#import "YDPartnerDetailController.h"
#import "YDDrugDetailsController.h"
#import "YDFroidController.h"
#import "MJRefresh.h"
#import "YDDurgsTwoCell.h"
#import "MBProgressHUD+MJ.h"

#define kURL @"http://openapi.ypt.langma.cn/yws/?json=%7B%0A%20%20%22op_type%22%20%3A%201003%2C%0A%20%20%22c_ver%22%20%3A%20%224.0.0%22%2C%0A%20%20%22c_type%22%20%3A%200%2C%0A%20%20%22uid%22%20%3A%200%2C%0A%20%20%22cid%22%20%3A%200%0A%7D"

#define kPartnerUrl @"http://openapi.db.39.net/app/GetDrugCompany?app_key=app&sign=9DFAAD5404FCB6168EA6840DCDFF39E5"

@interface YDMainPageViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) UIScrollView *headerView;
@property (nonatomic, strong) NSMutableArray *sectionTitle;
@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *typesArray;
@property (nonatomic, strong) NSMutableArray *PartnerArray;
@end

@implementation YDMainPageViewController

- (NSMutableArray *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}
- (NSMutableArray *)typesArray {
    if (!_typesArray) {
        _typesArray = [NSMutableArray array];
    }
    return _typesArray;
}
- (NSMutableArray *)PartnerArray {
    if (!_PartnerArray) {
        _PartnerArray = [NSMutableArray array];
    }
    return _PartnerArray;
}
- (NSMutableArray *)sectionTitle {
    if (!_sectionTitle) {
        _sectionTitle = [NSMutableArray array];
    }
    return _sectionTitle;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    self.navigationItem.title = @"群药荟萃";
    self.view.backgroundColor = [UIColor redColor];
    //    定义抽屉left按钮
    [self setupLeftMenuButton];
    
    
    //  添加 searchBar，加载到UINavagationBar
    UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    searchBar.delegate = self ;
    self.navigationItem.titleView = searchBar ;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    //    [self tableViewWithHeaderView:self.tableView];
    
    
    [self request];
    [self requestPartner];
    
    
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YDCategoryCell *category = [YDCategoryCell cellWithTableView:tableView];
        category.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [category.scan addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
        [category.advisory addTarget:self action:@selector(advisory) forControlEvents:UIControlEventTouchUpInside];
        [category.dose addTarget:self action:@selector(dose) forControlEvents:UIControlEventTouchUpInside];
        [category.drug addTarget:self action:@selector(drug) forControlEvents:UIControlEventTouchUpInside];
        
        return category;
    }
    else if (indexPath.section == 1) {
        YDMustHavesCell *mustHave = [YDMustHavesCell mustCellWithTableView:tableView];
        mustHave.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.bannerArray.count != 0) {
            YDUsuallyModel *model = self.bannerArray[1];
            [mustHave.must setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.image_url]];
            
            YDUsuallyModel *model2 = self.bannerArray[2];
            [mustHave.must2 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model2.image_url]];
        }
        [mustHave.must addTarget:self action:@selector(must) forControlEvents:UIControlEventTouchUpInside];
        [mustHave.must2 addTarget:self action:@selector(must2) forControlEvents:UIControlEventTouchUpInside];
        return mustHave;
    }
    else if (indexPath.section == 4) {
        YDPartnerCell *partner = [YDPartnerCell tradeCellWithTableView:tableView];
        partner.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.PartnerArray.count != 0) {
            
            for (int i=0; i<partner.uiarr.count; i++) {
                
                YDPartnerModel *model = self.PartnerArray[i];
                
                NSArray *t = partner.uiarr[i];
                
                UIButton *btn = t.firstObject;
                [btn addTarget:self action:@selector(partn:) forControlEvents:UIControlEventTouchUpInside];
                
                UIImageView *image = (UIImageView *)t[1];
                NSMutableString *str = [model.titleimg mutableCopy];
                [str insertString:@"n" atIndex:7];
                [image setImageWithURL:[NSURL URLWithString:str]];
                
                UILabel *label = (UILabel *)t.lastObject;
                label.text = model.namecn;
            }
        }
        return partner;
    }
    else if (indexPath.section == 2) {
        NSArray *temp = [NSArray array];
        
        YDDurgsCell *durgsCell = [YDDurgsCell drugsCellWithTableView:tableView];
        durgsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.typesArray.count != 0) {
            
//            if (indexPath.section == 2) {
                temp = self.typesArray.firstObject;
//            }
//            else {
//                temp = self.typesArray.lastObject;
//            }
            
            for (int i=0; i<temp.count; i++) {
                YDCategoryModel *model = temp[i];
                NSArray *t = durgsCell.uiArr[i];
                
                UIButton *btn = t.firstObject;
                
                
                [btn addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
                
                UIImageView *image = (UIImageView *)t[1];
                NSMutableString *str = [model.TitleImg mutableCopy];
                [str insertString:@"n" atIndex:7];
                [image setImageWithURL:[NSURL URLWithString:str]];
                UILabel *label = (UILabel *)t[2];
                label.text = model.NameCN;
                UILabel *price = (UILabel *)t[3];
                price.text = [NSString stringWithFormat:@"￥%@",model.AvgPrice];
            }
        }
        return durgsCell;
    } else {
        NSArray *temp = [NSArray array];
        
        YDDurgsTwoCell *durgs = [YDDurgsTwoCell drugsCellWithTableView:tableView];
        durgs.selectionStyle = UITableViewCellSelectionStyleNone;
        temp = self.typesArray.lastObject;
        for (int i=0; i<temp.count; i++) {
            YDCategoryModel *model = temp[i];
            NSArray *t = durgs.addui[i];
            
            UIButton *btn = t.firstObject;
            
            
            [btn addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *image = (UIImageView *)t[1];
            NSMutableString *str = [model.TitleImg mutableCopy];
            [str insertString:@"n" atIndex:7];
            [image setImageWithURL:[NSURL URLWithString:str]];
            UILabel *label = (UILabel *)t[2];
            label.text = model.NameCN;
            UILabel *price = (UILabel *)t[3];
            price.text = [NSString stringWithFormat:@"￥%@",model.AvgPrice];
        }
        return durgs;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YDSectionHeaderView *header = [YDSectionHeaderView headerViewWith:tableView];
    if (section == 2) {
        if (self.sectionTitle.count != 0) {
            header.durgsLabel.text = self.sectionTitle[0];
            [header.backBtn addTarget:self action:@selector(Cold) forControlEvents:UIControlEventTouchUpInside];
        }
        return header;
    }
    else if (section == 4){
        if (self.sectionTitle.count != 0) {
            header.durgsLabel.text = @"品牌合作";
        }
        [header.backBtn addTarget:self action:@selector(Partner) forControlEvents:UIControlEventTouchUpInside];
        return header;
    }
    else {
        if (self.sectionTitle.count != 0) {
            header.durgsLabel.text = self.sectionTitle[1];
            [header.backBtn addTarget:self action:@selector(Chronic) forControlEvents:UIControlEventTouchUpInside];
        }
        return header;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    }
    if (indexPath.section == 1) {
        return 100;
    }
    if (indexPath.section == 4) {
        return 160;
    }
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return 0;
    }
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSLog(@"%ld",indexPath.row);
}

- (void)scan {
    YDScanController *scanVc = [[YDScanController alloc] init];
    [self.navigationController pushViewController:scanVc animated:YES];
}
- (void)advisory {
    YDAdvisoryController *AdVc = [[YDAdvisoryController alloc] init];
    [self.navigationController pushViewController:AdVc animated:YES];
}
- (void)dose {
    YDRemindController *remindVc = [[YDRemindController alloc] init];
    [self.navigationController pushViewController:remindVc animated:YES];
}
- (void)drug {
    YDFindController *findVc = [[YDFindController alloc] init];
    [self.navigationController pushViewController:findVc animated:YES];
}
- (void)must {
    YDMustHavesController *mustHavesVc = [[YDMustHavesController alloc] init];
    YDUsuallyModel *model = [[YDUsuallyModel alloc] init];
    model = self.bannerArray[1];
    mustHavesVc.titleName = model.title;
    [self.navigationController pushViewController:mustHavesVc animated:YES];
}
- (void)must2 {
    YDMustHavesController *mustHavesVc = [[YDMustHavesController alloc] init];
    [self.navigationController pushViewController:mustHavesVc animated:YES];
}
- (void)Partner {
    YDPartnerController *partnerVc = [[YDPartnerController alloc] init];
    partnerVc.PartnerArray = self.PartnerArray;
    [self.navigationController pushViewController:partnerVc animated:YES];
}
- (void)Cold { // 感冒
    YDFroidController *froidVc = [[YDFroidController alloc] init];
    froidVc.category = self.sectionTitle.firstObject;
    [self.navigationController pushViewController:froidVc animated:YES];
}
- (void)Chronic { // 慢性
    YDFroidController *froidVc = [[YDFroidController alloc] init];
    froidVc.category = self.sectionTitle.lastObject;
    [self.navigationController pushViewController:froidVc animated:YES];
}

- (void)detail:(UIButton *)sender {
    
    YDCategoryModel *model = [[YDCategoryModel alloc] init];
    
    if (sender.tag >= 200 && sender.tag <204 ) {
        model = [self.typesArray.lastObject objectAtIndex:sender.tag - 200];
    } else {
        model = [self.typesArray.firstObject objectAtIndex:sender.tag - 300];
    }
    YDDrugDetailsController *ddVc = [[YDDrugDetailsController alloc] init];
    
    ddVc.ID = model.id;
    ddVc.name = model.NameCN;
    
    [self.navigationController pushViewController:ddVc animated:YES];
}

- (void)partn:(UIButton *)sender {
    YDPartnerDetailController *padeVc = [[YDPartnerDetailController alloc] init];
    YDPartnerModel *model = self.PartnerArray[sender.tag - 100];
    
    padeVc.name = model.namecn;
    [self.navigationController pushViewController:padeVc animated:YES];
}

#pragma 轮播图 / 家庭药箱等
- (void)request {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:kURL parameters:nil success:
     
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSData *data = operation.responseData;
         
         NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
         NSMutableDictionary *listDic = dict[@"list"];
         
         self.bannerArray = [YDUsuallyModel objectArrayWithKeyValuesArray:listDic[@"banner"]];
         
         
         NSMutableArray *typesArr = listDic[@"types"];
         
         
         for (NSMutableDictionary *dictionary in typesArr) {
             
             NSMutableArray *temp1 = [dictionary objectForKey:@"drug_list"];
             
             [self.sectionTitle addObject:[dictionary objectForKey:@"type_name"]];
             
             NSMutableArray *temparr = [NSMutableArray array];
             
             for (NSMutableDictionary *tempDic in temp1) {
                 YDCategoryModel *categoryModel = [YDCategoryModel modelWithDictionary:tempDic];
                 
                 [temparr addObject:categoryModel];
                 
             }
             
             [self.typesArray addObject:temparr];
             [self.tableView reloadData];
         }
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [MBProgressHUD showError:@"网络异常,请稍后再试!"];
         }];
}

#pragma mark 合作商
- (void)requestPartner {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:kPartnerUrl parameters:nil success:
     
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSData *data = operation.responseData;
         
         NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
         NSMutableArray *resultesArr = [dict objectForKey:@"results"];
         
         for (NSMutableDictionary *dictionary in resultesArr) {
             YDPartnerModel *model = [YDPartnerModel modelWithDictionary:dictionary];
             [self.PartnerArray addObject:model];
         }
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
            [MBProgressHUD showError:@"网络异常,请稍后再试!"];
         }];
}


#pragma mark -    定义抽屉left按钮
-(void)setupLeftMenuButton
{
    UIButton * classButton = [UIButton buttonWithType:UIButtonTypeSystem] ;
    classButton.frame = CGRectMake(0, 0, 30, 30) ;    
    [classButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside] ;
    [classButton setImage:[UIImage imageNamed:@"tabbar_classify_selected@3x.png"] forState:UIControlStateNormal] ;
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:classButton] ;
    
    [self.navigationItem setLeftBarButtonItem:leftButton animated:YES];
}



#pragma mark -  抽屉left按钮触发的方法
-(void)leftDrawerButtonPress:(id)sender
{
    //  打开左侧抽屉
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark - UISearchBar的代理方法
//  点击键盘的搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"search bar  编辑结束");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
