//
//  YDDrugDetailsController.m
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDDrugDetailsController.h"
#import "YDDrugDetailsHeaderView.h"
#import "YDDrugDetailsSectionHeaderView.h"
#import "YDDrugDetailInstructionsCell.h"
#import "YDDrugCounselingModel.h"
#import "AFNetworking.h"
#import "YDMedicationReviewsModel.h"
#import "YDDrugCounselingCelll.h"
#import "YDInstructionsCell.h"
#import "YDInstructionsModel.h"
#import "YDConst.h"
#import "UIImageView+AFNetworking.h"
#import "UIBarButtonItem+Extension.h"
#import "MBProgressHUD+MJ.h"
#import "YDPriceModel.h"
#import "YDSimilarCell.h"
#import "ZOLRequestManger.h"
#import "YDDrugPriceModel.h"
#import "MJExtension.h"
#import "YDDrugsPriceCell.h"
#import "YDToll.h"
#import "UIView+Extension.h"
//点评
#define kURLH @"http://openapi.db.39.net/app/GetDrugComments?Limit=30&app_key=app&curPage=1&drugId="
#define kURLF @"&sign=9DFAAD5404FCB6168EA6840DCDFF39E5"

//提问
#define kH @"http://openapi.db.39.net/app/GetDrugAsk?app_key=app&curPage=1&drugName=@"
#define kF @"&limit=20&sign=9DFAAD5404FCB6168EA6840DCDFF39E5"

//详细    不加用户
#define kINH @"http://openapi.db.39.net/app/GetDrugById?app_key=app&id="
#define kINF @"&sign=9DFAAD5404FCB6168EA6840DCDFF39E5"

//扫码
#define kUH @"http://openapi.db.39.net/app/GetDrugByBar?app_key=app&barcode="
#define kUF @"&sign=9DFAAD5404FCB6168EA6840DCDFF39E5"

//药价
#define kDPRICH @"http://openapi.db.39.net/app/GetDrugPrice?app_key=app&drugId="
#define kDPRICF @"&sign=9DFAAD5404FCB6168EA6840DCDFF39E5&ver=2"

@interface YDDrugDetailsController ()
{
    NSInteger _location;
}
@property (nonatomic, strong) NSMutableArray *medicationReviewsArray;
@property (nonatomic, strong) NSMutableArray *drugCounselingArray;
@property (nonatomic, strong) NSMutableArray *instrutionsArray;
@property (nonatomic, strong) NSMutableArray *priceArray;
@property (nonatomic, strong) NSMutableArray *durgspriceArray;
@property (nonatomic, strong) NSMutableArray *attArray;

@property (nonatomic, strong) YDDrugDetailsSectionHeaderView *hand;
@property (nonatomic, strong) YDDrugDetailsHeaderView *top;

@property (nonatomic, strong) YDDrugDetailInstructionsCell *addCell;
@property (nonatomic, strong) NSIndexPath *index;
@end

@implementation YDDrugDetailsController

static NSString *ID = @"caonima";

- (NSMutableArray *)medicationReviewsArray {
    if (_medicationReviewsArray == nil) {
        _medicationReviewsArray = [NSMutableArray array];
    }
    return _medicationReviewsArray;
}
- (NSMutableArray *)drugCounselingArray {
    if (_drugCounselingArray == nil) {
        _drugCounselingArray = [NSMutableArray array];
    }
    return _drugCounselingArray;
}
- (NSMutableArray *)priceArray {
    if (_priceArray == nil) {
        _priceArray = [NSMutableArray array];
    }
    return _priceArray;
}
- (NSMutableArray *)durgspriceArray {
    if (_durgspriceArray == nil) {
        _durgspriceArray = [NSMutableArray array];
    }
    return _durgspriceArray;
}

- (void)leftItem {
    self.navigationItem.title = @"药品详情";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabBar"] forBarMetrics:0];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    left.image = [UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *share = [UIBarButtonItem itemWithTarget:self action:@selector(share:) image:@"share_normal" highImage:@"share_selected"];

    UIBarButtonItem *collect = [UIBarButtonItem itemWithTarget:self action:@selector(collect:) image:@"details_collect_normal" highImage:@"details_collect_selected"];
    
    self.navigationItem.rightBarButtonItems = @[share ,collect];
}
- (void)left {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)share:(UIBarButtonItem *)item {
    NSLog(@"分享");
}
- (void)collect:(UIBarButtonItem *)item {
    NSLog(@"收藏");

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self leftItem];
    _location = 0;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self tableViewWithHeaderView:self.tableView];
    self.tableView.sectionHeaderHeight = 30;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YDDrugsPriceCell" bundle:nil] forCellReuseIdentifier:ID];
    
    [self requestmedicationReviews];
    [self requestPrice];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tableViewWithHeaderView:(UITableView *)tableView {
    self.top = [[YDDrugDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH / 3 + 35)];
    tableView.tableHeaderView = self.top;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        self.hand = [YDDrugDetailsSectionHeaderView headerViewWithTableView:tableView];
        
        for (NSArray *arr in self.hand.uiarr) {
            UIButton *button = (UIButton *)arr.firstObject;
            
            [button addTarget:self action:@selector(didselect:) forControlEvents:UIControlEventTouchUpInside];
        }
        return self.hand;
    } else if (section == 2){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        view.backgroundColor = YDGlobalBg;
        view.alpha = 0.4;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, 29, SCREEN_WIDTH - 10, 1)];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.4;
        [view addSubview:line];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        label.text = @"同类药";
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        return view;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        view.backgroundColor = YDGlobalBg;
        view.alpha = 0.4;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, 29, SCREEN_WIDTH - 10, 1)];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.4;
        [view addSubview:line];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        label.text = @"网上报价";
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        return view;
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    if (_location == 0) {
//        if (section != 0 || section != 1) {
//            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
//            view.backgroundColor = [UIColor grayColor];
//            return view;
//        }
//    }
//        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
//        return view;
//}

- (void)didselect:(UIButton *)sender {

    _location = sender.tag - 1000;
    
    [self.hand setHidenWith:sender.tag - 1000];
    
    [self requestmedicationReviews];
}

- (void)selectOther:(UIButton *)sender {

    YDDrugDetailsController *ddVc = [[YDDrugDetailsController alloc] init];
    YDPartnerDetailModel *model = self.priceArray[sender.tag - 111];

    ddVc.ID = [NSString stringWithFormat:@"%ld",model._id];
    ddVc.name = model.namecn;
    
    [self.navigationController pushViewController:ddVc animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_location == 0) {
        return 3;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_location == 1) {
        return self.medicationReviewsArray.count;
    } else if (_location == 2) {
         return self.drugCounselingArray.count;
    } else if (_location == 3){
        return self.attArray.count;
    } else {
        if (section == 2) {
            return 1;
        } else {
//            NSLog(@"%ld",self.drugCounselingArray.count);
            return self.drugCounselingArray.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_location == 1) {
        
        YDDrugDetailInstructionsCell *cell = [YDDrugDetailInstructionsCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.medicationReviewsArray.count != 0) {
            YDMedicationReviewsModel *model=self.medicationReviewsArray[indexPath.row];
            [cell cellsetModel:model];
        }
        
        self.addCell = cell;
        self.index = indexPath;
        [cell likeAddTarget:self action:@selector(likeAdd)];
        
        return cell;
    } else if (_location == 2) {
        /**
         *  咨询
         */
        static NSString * cellIndentifier = @"DrugCounseling";
        [tableView registerClass:[YDDrugCounselingCelll class] forCellReuseIdentifier:cellIndentifier];
        YDDrugCounselingCelll *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.drugCounselingArray.count != 0) {
            YDDrugCounselingModel *model = self.drugCounselingArray[indexPath.row];
            [cell cellsetModel:model];
        }
        return cell;
    } else if (_location == 3){
        /**
         *  说明书
         */
        static NSString *ID = @"Instructions";
        [tableView registerClass:[YDInstructionsCell class] forCellReuseIdentifier:ID];
        YDInstructionsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.instrutionsArray.count != 0) {
            [cell cellsetModelInfo:self.attArray[indexPath.row] index:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        
        if (indexPath.section == 2) {
            static NSString * ID = @"Similar";
            [tableView registerClass:[YDSimilarCell class] forCellReuseIdentifier:ID];
            YDSimilarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
            [cell setBtnTarget:self action:@selector(selectOther:)];
            [cell cellSetModel:self.priceArray];
            return cell;
        }
        
        
        
       
        YDDrugsPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
        if (self.drugCounselingArray != 0) {
            YDDrugPriceModel *model = self.drugCounselingArray[indexPath.row];
            [cell cellSetModel:model];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_location == 1) {
        YDMedicationReviewsModel *model = [self.medicationReviewsArray objectAtIndex:indexPath.row];
        return [YDDrugDetailInstructionsCell heightForCell:model];
    } else if (_location == 2) {
        YDDrugCounselingModel *model = self.drugCounselingArray[indexPath.row];
        return [YDDrugCounselingCelll heightForCell:model];
    } else if (_location == 3){
        NSString *info = self.attArray[indexPath.row];
        if (info.length == 0) {
            return 0;
        } else {
            return [YDInstructionsCell heightForCell:info];
        }
    } else {
        if (indexPath.section == 0) {
            return 0;
        } else if (indexPath.section == 3){
            return 130;
        } else {
            return 30;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)likeAdd {
//    NSLog(@"%ld",self.index.row);
    YDMedicationReviewsModel *model=self.medicationReviewsArray[self.index.row];
    [self.addCell changeImageWith:model];
}

#pragma mark 药品详情
- (void)requestmedicationReviews {
    
    NSString *url = nil;
    
    if (_location == 1) {
        if (self.ID) {
            url = [NSString stringWithFormat:@"%@%ld%@",kURLH, (long)self.ID.integerValue, kURLF];
        } else {
            url = [NSString stringWithFormat:@"%@%ld%@",kURLH, (long)self.model._id, kURLF];
        }
    } else if (_location == 2) {
        if (self.name) {
            url = [NSString stringWithFormat:@"%@%@%@",kH, [self.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], kF];
        } else {
            url = [NSString stringWithFormat:@"%@%@%@",kH, [self.model.namecn stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], kF];
        }
    } else if (_location == 3) {
        if (self.ID) {
            url = [NSString stringWithFormat:@"%@%ld%@",kINH, (long)self.ID.integerValue, kINF];
        } else {
            url = [NSString stringWithFormat:@"%@%ld%@",kINH, (long)self.model._id, kINF];
        }
    } else {
        if (self.ID) {
            url = [NSString stringWithFormat:@"%@%@%@",kINH, self.ID, kINF];
        } else if (self.barcode) {
            url = [NSString stringWithFormat:@"%@%@%@",kUH, self.barcode, kUF];
        } else {
            url = [NSString stringWithFormat:@"%@%ld%@",kINH, (long)self.model._id, kINF];
        }
        
    }
//    NSLog(@"%@",url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:
     
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSData *data = operation.responseData;
         
         NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
         NSMutableDictionary *resultesDic = [dict objectForKey:@"results"];
         
         if (_location == 3 || _location == 0) {

             YDInstructionsModel *model = [YDInstructionsModel objectWithKeyValues:dict[@"results"]];
             [self.instrutionsArray addObject:model];
             
             self.instrutionsArray = [NSMutableArray array];
             self.attArray = [NSMutableArray array];
             

             for (NSMutableDictionary *price in model.SameDrugs) {
                 YDPriceModel *prc = [YDPriceModel modelWithDictionary:price];
                 [self.priceArray addObject:prc];
             }
             
             
//        [self.attArray addObject:[NSString stringWithFormat:@"%ld",model._id]];
            [self.attArray addObject:model.namecn];
            [self.attArray addObject:model.composition];
            [self.attArray addObject:model.drugattribute];
            [self.attArray addObject:model.gongneng];
            [self.attArray addObject:model.unit];
            [self.attArray addObject:model.usage];
            [self.attArray addObject:model.adr]; //不良反应
            [self.attArray addObject:model.contraindication];
            [self.attArray addObject:model.note];
            [self.attArray addObject:model.pregnantwomentaboo];
            [self.attArray addObject:model.childrentaboo];
            [self.attArray addObject:model.elderlytaboo];
            [self.attArray addObject:model.interaction];
            [self.attArray addObject:model.pharmacology];
            [self.attArray addObject:model.storage];
            [self.attArray addObject:model.shelflife];
            [self.attArray addObject:model.codename];
            [self.attArray addObject:model.standard];
            [self.attArray addObject:model.specificationdate];
            [self.attArray addObject:model.refdrugcompanyname];
         
            [self.top setModel:model];
         }
         if (_location == 1 || _location == 2) {
             
             NSMutableArray *listArr = resultesDic[@"List"];
             
             for (NSMutableDictionary *dictionary in listArr) {
                 if (_location == 1) {
                     YDMedicationReviewsModel *model = [YDMedicationReviewsModel modelWithDictionary:dictionary];
                     [self.medicationReviewsArray addObject:model];
                 } else if (_location == 2) {
                     YDDrugCounselingModel *model = [YDDrugCounselingModel modelWithDictionary:dictionary];
                     [self.drugCounselingArray addObject:model];
                 }
             }
         }
         [self.tableView reloadData];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [MBProgressHUD showError:@"网络繁忙,请稍后再试!"];
         }];
}

- (void)requestPrice {
    NSString *url = nil;

    if (self.ID) {
        url = [NSString stringWithFormat:@"%@%@%@",kDPRICH,self.ID,kDPRICF];
    } else {
        url = [NSString stringWithFormat:@"%@%ld%@",kDPRICH,self.model._id,kDPRICF];
    }
//    NSLog(@"%@",url);
    
    [ZOLRequestManger GET:url success:^(id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        self.drugCounselingArray = [YDDrugPriceModel objectArrayWithKeyValuesArray:dict[@"Online"]];
//        NSLog(@"%@",[YDDrugPriceModel objectArrayWithKeyValuesArray:dict[@"Online"]]);
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络繁忙,请稍后再试!"];
    }];
}
@end
