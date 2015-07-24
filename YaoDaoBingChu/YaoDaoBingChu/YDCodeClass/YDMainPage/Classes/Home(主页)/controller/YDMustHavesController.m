//
//  YDMustHavesController.m
//  text
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kMedicineChest @"http://openapi.ypt.langma.cn/yws/?json=%7B%0A%20%20%22op_type%22%20%3A%201006%2C%0A%20%20%22c_ver%22%20%3A%20%224.0.0%22%2C%0A%20%20%22c_type%22%20%3A%200%2C%0A%20%20%22uid%22%20%3A%200%2C%0A%20%20%22activity_id%22%20%3A%20%221%22%2C%0A%20%20%22cid%22%20%3A%200%0A%7D"

#define kVitamins @"http://openapi.ypt.langma.cn/yws/?json=%7B%0A%20%20%22op_type%22%20%3A%201006%2C%0A%20%20%22c_ver%22%20%3A%20%224.0.0%22%2C%0A%20%20%22c_type%22%20%3A%200%2C%0A%20%20%22uid%22%20%3A%200%2C%0A%20%20%22activity_id%22%20%3A%20%222%22%2C%0A%20%20%22cid%22%20%3A%200%0A%7D"

#import "YDMustHavesController.h"
#import "YDMedicineChestCell.h"
#import "YDMedicineChestModel.h"
#import "UIImageView+AFNetworking.h"
#import "YDDrugDetailsController.h"
#import "MBProgressHUD+MJ.h"
@interface YDMustHavesController ()

@property (nonatomic, strong) UIImageView *headerImage;
//@property (nonatomic, strong) NSMutableArray *otherArray;
@property (nonatomic, strong) NSMutableArray *medicineChestArray;
@end

@implementation YDMustHavesController

static NSString * const reuseIdentifier = @"MedicineChest";

- (NSMutableArray *)medicineChestArray {
    if (_medicineChestArray == nil) {
        _medicineChestArray = [NSMutableArray array];
    }
    return _medicineChestArray;
}

//- (NSMutableArray *)otherArray {
//    if (_otherArray == nil) {
//        _otherArray = [NSMutableArray array];
//    }
//    return _otherArray;
//}

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
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    left.image = [UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem = left;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;


    //加载头部
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];

    //加载XIB
    [self.collectionView registerNib:[UINib nibWithNibName:@"YDMedicineChestCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    //数据解析
    [self requestMedicineChest];
}

#pragma mark - 头部图片 -
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
    
    self.headerImage = [[UIImageView alloc] initWithFrame:header.frame];
    [header addSubview:self.headerImage];
    return header;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 180);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSLog(@"%lu",(unsigned long)self.medicineChestArray.count);
    return self.medicineChestArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YDMedicineChestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (self.medicineChestArray.count != 0 ) {
        
        YDMedicineChestModel *model = self.medicineChestArray[indexPath.item];
        NSMutableString *str = [model.TitleImg mutableCopy];
        if ([str isEqualToString:@""]) {
            [str insertString:@"n" atIndex:7];
        }
       
        [cell.medicineChestPic setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"drug_placeholder"]];
        cell.titleLabel.text = model.NameCN;
        if (![model.AvgPrice isEqualToString:@"0.0"]) {
            cell.medicineChestPrice.text = [NSString stringWithFormat:@"￥%@",model.AvgPrice];
        } else {
            cell.medicineChestPrice.text = @"暂无报价";
        }
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    YDDrugDetailsController *ddVc = [[YDDrugDetailsController alloc] init];
    YDMedicineChestModel *model = self.medicineChestArray[indexPath.item];
    ddVc.ID = model.id;
    ddVc.name = model.NameCN;
    [self.navigationController pushViewController:ddVc animated:YES];
}

#pragma mark 家庭药箱
- (void)requestMedicineChest {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = nil;
    if ([self.titleName isEqualToString:@"家庭药箱"]) {
        url = kMedicineChest;
    } else {
        url = kVitamins;
    }
    
    [manager GET:url parameters:nil success:
     
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSData *data = operation.responseData;
         
         NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         NSMutableDictionary *listDic = [dict objectForKey:@"list"];
         
         NSMutableArray *drug_listArr = [listDic objectForKey:@"drug_list"];
         
         NSString *activity_name = [listDic objectForKey:@"activity_name"];
         self.navigationItem.title = activity_name;
         
         NSString *banner_image_url = [listDic objectForKey:@"banner_image_url"];
         [self.headerImage setImageWithURL:[NSURL URLWithString:banner_image_url] placeholderImage:[UIImage imageNamed:@"drug_placeholder"]];
         
//         NSString *banner_jump_url = [listDic objectForKey:@"banner_jump_url"];
//         [self.otherArray addObject:activity_name];
//         [self.otherArray addObject:banner_jump_url];
//         [self.otherArray addObject:banner_image_url];
         
         for (NSMutableDictionary *dictionary in drug_listArr) {
             YDMedicineChestModel *model = [YDMedicineChestModel modelWithDictionary:dictionary];
             [self.medicineChestArray addObject:model];
             [self.collectionView reloadData];
         }
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [MBProgressHUD showError:@"网络异常,请稍后再试!"];
         }];
}
@end
