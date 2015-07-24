//
//  YDPartnerDetailController.m
//  text
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDPartnerDetailController.h"
#import "YDMedicineChestCell.h"
#import "AFNetworking.h"
#import "YDPartnerDetailModel.h"
#import "UIImageView+AFNetworking.h"
#import "YDCollectionHeaderVIew.h"
#import "YDConst.h"
#import "YDDrugDetailsController.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#define kPartner @"http://openapi.db.39.net/app/GetDrugs?app_key=app&curPage=0&limit=20&sign=9DFAAD5404FCB6168EA6840DCDFF39E5&tags=&word="

@interface YDPartnerDetailController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _myTableView ;
    BOOL _isExpand ; // 判断tableView的状态：隐藏 或 显示
    NSArray *_one;
    UIButton *_button; //遮盖
    NSInteger _index;
    NSString *cate;
    
    NSInteger _tag;
}

@property (nonatomic, strong) NSMutableArray *category;
@property (nonatomic, strong) NSMutableArray *detailPartnerArray;
@property (nonatomic, strong) YDCollectionHeaderVIew *collHeader;
@end

@implementation YDPartnerDetailController

static NSString * const reuseIdentifier = @"MedicineChest";

- (NSMutableArray *)detailPartnerArray {
    if (_detailPartnerArray == nil) {
        _detailPartnerArray = [NSMutableArray array];
    }
    return _detailPartnerArray;
}

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //指定大小
    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 2, 180);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return [self initWithCollectionViewLayout:layout];
}

- (void)left {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    left.image = [UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem = left;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.frame = CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    //加载XIB
    [self.collectionView registerNib:[UINib nibWithNibName:@"YDMedicineChestCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //头部
    self.category = [NSMutableArray array];
    
    [self header];
    [self table];
    [self requestPartnerDetail];
    
    //监听
    [YDNotificationCenter addObserver:self selector:@selector(partnerSelect:) name:YDPartnerNotification object:nil];
    
    //刷新
    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfo)];
}

- (void)loadMoreInfo {
    NSLog(@"刷新");
}


/**
 *  执行监听方法
 */
- (void)partnerSelect:(NSNotification *)notification {

    NSArray *array = _collHeader.uiarr[_index];
    UILabel *label = (UILabel *)array[1];
    label.text = notification.userInfo[YDSelectPartnerName];
    
    cate = notification.userInfo[YDSelectPartnerName];
    
    
    [self.collectionView reloadData];
}

/**
 *  移除监听
 */
- (void)dealloc {
    [YDNotificationCenter removeObserver:self];
}

- (void)table {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
    [self.view addSubview:_myTableView];
    _myTableView.rowHeight = 30;
    _myTableView.alpha = 0 ;
    _myTableView.delegate = self ;
    _myTableView.dataSource = self ;
    
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = self.view.frame;
    _button.backgroundColor = [UIColor blackColor];
    _button.alpha = 0;
    [self.view addSubview:_button];
    [_button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancel {
    NSArray *array = _collHeader.uiarr[_index];
    UIImageView *image = (UIImageView *)array.lastObject;
    
    [UIView animateWithDuration:0.5 animations:^{
        _button.alpha = 0;
        _myTableView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 0);
        _myTableView.alpha = 0;
        image.transform = CGAffineTransformMakeRotation(0);
        _isExpand = !_isExpand;
    }];
}

- (void)header {
    self.collHeader = [[YDCollectionHeaderVIew alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [self.view addSubview:_collHeader];
    
    NSArray *temp = @[@"不限制",@"步长",@"科伦", @"恒瑞", @"罗氏", @"云南白药", @"辉瑞", @"拜耳", @"葛兰素史克", @"阿斯利康",@"同仁堂", @"诺华", @"杭州默沙东", @"赛诺菲安万特"];
    NSArray *temp2 = @[@"不限制",@"1-20元",@"20-50元", @"50-100元", @"100-200元", @"200元以上"];
    NSArray *temp3 = @[@"不限制",@"医保",@"非医保"];
    NSArray *temp4 = @[@"不限制",@"基本药物",@"非基本药物"];
    
    [self.category addObject:temp];
    [self.category addObject:temp2];
    [self.category addObject:temp3];
    [self.category addObject:temp4];
    
    for (NSArray *arr in _collHeader.uiarr) {
        UIButton *btn = (UIButton *)arr.firstObject;
        [btn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)select:(UIButton *)sender {
    
    _one = [NSArray array];
    _one = [self.category objectAtIndex:sender.tag - 100];
    _index = sender.tag - 100;
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    
    
    
    if (_tag == sender.tag) {
        
        NSArray *array = _collHeader.uiarr[_tag - 100];
        UIImageView *image = (UIImageView *)array.lastObject;
        
        if (_isExpand == NO) {
            
            
            
            _myTableView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 30 * _one.count);
            if (_myTableView.frame.size.height > SCREEN_HEIGHT / 2) {
                _myTableView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 200);
            }
            _myTableView.alpha = 1 ;
            
            _button.frame = CGRectMake(0, _myTableView.frame.origin.y + _myTableView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - _myTableView.frame.size.height);
            _button.alpha = 0.3;
            
            image.transform = CGAffineTransformMakeRotation(M_PI);
            
        } else {
            _button.alpha = 0;
            
            _myTableView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 0) ;
            _myTableView.alpha = 0 ;
            
            image.transform = CGAffineTransformMakeRotation(0);
        }
        
    } else {
        
        NSArray *array = _collHeader.uiarr[sender.tag - 100];
        UIImageView *image = (UIImageView *)array.lastObject;
        
        if (_tag != 0) {
            NSArray *beforeArr = _collHeader.uiarr[_tag - 100];
            UIImageView *before = (UIImageView *)beforeArr.lastObject;
            before.transform = CGAffineTransformMakeRotation(0);
        }
        
        
        _myTableView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 30 * _one.count);
        if (_myTableView.frame.size.height > SCREEN_HEIGHT / 2) {
            _myTableView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 200);
        }
        _myTableView.alpha = 1 ;
        
        _button.frame = CGRectMake(0, _myTableView.frame.origin.y + _myTableView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - _myTableView.frame.size.height);
        _button.alpha = 0.3;
        
        image.transform = CGAffineTransformMakeRotation(M_PI);
        
    }
    
    _tag = sender.tag;
    
    
    
    
    [UIView commitAnimations];
    _isExpand = !_isExpand;
    
    [_myTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.detailPartnerArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YDMedicineChestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (self.detailPartnerArray.count != 0 ) {
        YDPartnerDetailModel *model = self.detailPartnerArray[indexPath.item];
        NSMutableString *str = [model.titleimg mutableCopy];

        if (![str isEqualToString:@""]) {
            [str insertString:@"n" atIndex:7];
        }

        [cell.medicineChestPic setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"drug_placeholder"]];
        cell.titleLabel.text = model.namecn;
        
        NSString *price = [NSString stringWithFormat:@"%f",model.avgprice];
        if (model.avgprice != 0.0) {
            cell.medicineChestPrice.text = [NSString stringWithFormat:@"￥%@",price];
            NSUInteger dotLoc = [cell.medicineChestPrice.text rangeOfString:@"."].location;
            if (dotLoc != NSNotFound) {
                // 超过2位小数
                if (cell.medicineChestPrice.text.length - dotLoc > 3) {
                    cell.medicineChestPrice.text = [cell.medicineChestPrice.text substringToIndex:dotLoc + 3];
                }
            }
        } else {
            cell.medicineChestPrice.text = @"暂无报价";
        }
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    YDDrugDetailsController *ddVc = [[YDDrugDetailsController alloc] init];
    YDPartnerDetailModel *model = self.detailPartnerArray[indexPath.item];
    ddVc.model = model;
    [self.navigationController pushViewController:ddVc animated:YES];
}

#pragma mark - tableView -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _one.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIndentifier = @"cell" ;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier] ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier] ;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = _one[indexPath.row];
    return cell;
}

//- (void)footerView {
//    UIButton *foot = [UIButton buttonWithType:UIButtonTypeCustom];
//    _myTableView.tableFooterView = foot;
//    foot.frame = CGRectMake(0, _myTableView.frame.origin.y + _myTableView.frame.size.height, SCREEN_WIDTH, 30);
//    [foot setImage:[UIImage imageNamed:@"icon_chose_bottom.png"] forState:UIControlStateNormal];
//    [foot addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [YDNotificationCenter postNotificationName:YDPartnerNotification object:nil userInfo:@{YDSelectPartnerName : _one[indexPath.row]}];
    
    [self cancel];
}

#pragma mark 品牌合作 细化
- (void)requestPartnerDetail {
    NSString *url = nil;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

//    if (self.name) {
        url = [kPartner stringByAppendingString:[self.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    } else {
//        url = [kPartner stringByAppendingString:[cate stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    }
    
//    NSLog(@"%@",url);
    
    [manager GET:url parameters:nil success:
     
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSData *data = operation.responseData;
         
         NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         NSDictionary *results = dict[@"results"];

         NSArray *List = results[@"List"];
         for (NSMutableDictionary *temp in List) {
             YDPartnerDetailModel *model = [YDPartnerDetailModel modelWithDictionary:temp];
             [self.detailPartnerArray addObject:model];
         }
         [self.collectionView reloadData];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             [MBProgressHUD showError:@"网络繁忙,请稍后再试!"];
         }];
}

//- (void)requestPartnerDetailAgain {
//    NSString *url = nil;
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    
//    url = [kPartner stringByAppendingString:[cate stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSLog(@"%@",url);
//    
//    [manager GET:url parameters:nil success:
//     
//     ^(AFHTTPRequestOperation *operation, id responseObject) {
//         
//         NSData *data = operation.responseData;
//         
//         NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//         NSDictionary *results = dict[@"results"];
//         
//         NSArray *List = results[@"List"];
//         for (NSMutableDictionary *temp in List) {
//             YDPartnerDetailModel *model = [YDPartnerDetailModel modelWithDictionary:temp];
//             [self.detailPartnerArray addObject:model];
//         }
//         [self.collectionView reloadData];
//     }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             
//             [MBProgressHUD showError:@"网络繁忙,请稍后再试!"];
//         }];
//}

//合作商 - 药品
//1.  http://openapi.db.39.net/app/GetDrugs?app_key=app&curPage=0&limit=20&sign=9DFAAD5404FCB6168EA6840DCDFF39E5&tags=&word=%E6%AD%A5%E9%95%BF
//
//切换 种类

//2.  http://openapi.db.39.net/app/GetDrugs?app_key=app&curPage=0&limit=20&sign=9DFAAD5404FCB6168EA6840DCDFF39E5&tags=&word=品牌名
//
//切换价格
//3.  http://openapi.db.39.net/app/GetDrugsByCategory?CategoryName=%E6%AD%A5%E9%95%BF&app_key=app&curPage=0&limit=20&sign=9DFAAD5404FCB6168EA6840DCDFF39E5&tags=价格
//
//医保 / 非医保
//4.  http://openapi.db.39.net/app/GetDrugsByCategory?CategoryName=%E6%AD%A5%E9%95%BF&app_key=app&curPage=0&limit=20&sign=9DFAAD5404FCB6168EA6840DCDFF39E5&tags=医保 / 非医保
//
//基本 / 非基本
//5.  http://openapi.db.39.net/app/GetDrugsByCategory?CategoryName=%E6%AD%A5%E9%95%BF&app_key=app&curPage=0&limit=20&sign=9DFAAD5404FCB6168EA6840DCDFF39E5&tags=基本 / 非基本

@end
