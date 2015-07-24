//
//  YDFroidController.m
//  text
//
//  Created by lanou3g on 15/7/19.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDFroidController.h"
#import "YDConst.h"
#import "YDMedicineChestCell.h"
#import "AFNetworking.h"

#import "YDPartnerDetailModel.h"
#import "UIImageView+AFNetworking.h"
#import "MJRefresh.h"
#import "YDDrugDetailsController.h"
#define kFROIDURLH @"http://openapi.db.39.net/app/GetDrugsByCategory?CategoryName="
#define kFROIDURLF @"&app_key=app&curPage=0&limit=20&sign=9DFAAD5404FCB6168EA6840DCDFF39E5&tags="
@interface YDFroidController ()

@property (nonatomic, strong) NSMutableArray * froidArray;
@property (nonatomic, strong) NSMutableArray * classIficationArray;
@end

@implementation YDFroidController

static NSString * const reuseIdentifier = @"MedicineChest";

- (NSMutableArray *)froidArray {
    if (_froidArray == nil) {
        _froidArray = [NSMutableArray array];
    }
    return _froidArray;
}
- (NSMutableArray *)classIficationArray {
    if (_classIficationArray == nil) {
        _classIficationArray = [NSMutableArray array];
    }
    return _classIficationArray;
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
- (void)leftItem {
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    left.image = [UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem = left;
    
}
- (void)left {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = YES;
    [self leftItem];
    
    //加载XIB
    [self.collectionView registerNib:[UINib nibWithNibName:@"YDMedicineChestCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self requestClassIfication];
    
    // 添加上拉刷新
//    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    
}
- (void)loadMoreDeals
{
    NSLog(@"2362");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.froidArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YDMedicineChestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (self.froidArray.count != 0 ) {
        YDPartnerDetailModel *model = self.froidArray[indexPath.item];
        NSMutableString *str = [model.titleimg mutableCopy];
        
        [str insertString:@"n" atIndex:7]; // 图片url 问题

//        NSLog(@"%@",str);
        
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
    YDPartnerDetailModel *model = self.froidArray[indexPath.item];
    ddVc.model = model;
    [self.navigationController pushViewController:ddVc animated:YES];
}
#pragma mark 品牌合作 细化
- (void)requestClassIfication {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *str = nil;
    
    if ([self.category isEqualToString:@"感冒用药"]) {
        str = @"解热镇痛";  // 默认的
    } else {
        str = @"心脑血管";
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@", kFROIDURLH, [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], kFROIDURLF];
    
//    NSLog(@"%@",url);
    
    [manager GET:url parameters:nil success:
     
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSData *data = operation.responseData;
         
         NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
         NSDictionary *results = dict[@"results"];
         
         self.classIficationArray = dict[@"Brands"];
         
         NSArray *List = results[@"List"];
         
         for (NSMutableDictionary *temp in List) {
             YDPartnerDetailModel *model = [YDPartnerDetailModel modelWithDictionary:temp];
             [self.froidArray addObject:model];
             
             [self.collectionView reloadData];
         }
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"下载错误 is %@",error);
         }];
}
@end
