//
//  MedicalNewsViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "MedicalNewsViewController.h"
#import "MedicaNewsModel.h"
#import "MedicalNewsCollectionViewCell.h"
#import "MedicalNewsDetailViewController.h"

#define MedicalNewsURL @"http://m.jkepd.com/shipinjson.php?ac=list&t=wxw&c=new&pageNum=1"

@interface MedicalNewsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *modelArray;

@end

@implementation MedicalNewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestDataOfMedicalNews];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 65) collectionViewLayout:layout];
    //self.collectionView.backgroundColor = [UIColor cyanColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    BackImageView *back = [[BackImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) image:@"view.jpg"];
    self.collectionView.backgroundView = back;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[MedicalNewsCollectionViewCell class] forCellWithReuseIdentifier:@"medicalNews"];
}

- (void)requestDataOfMedicalNews
{
    [LORequestManger GET:MedicalNewsURL success:^(id response) {
        NSDictionary *dict = (NSDictionary *)response;
        NSDictionary *responseDict = dict[@"response"];
        self.modelArray = [NSMutableArray array];
        for (NSDictionary *items in responseDict[@"items"])
        {
            MedicaNewsModel *model = [[MedicaNewsModel alloc] init];
            [model setValuesForKeysWithDictionary:items];
            [self.modelArray addObject:model];
        }
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalNewsCollectionViewCell *medicalNewsCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"medicalNews" forIndexPath:indexPath];
    MedicaNewsModel *model = self.modelArray[indexPath.item];
    [medicalNewsCell setValueForCellWithModel:model];
    return medicalNewsCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalNewsDetailViewController *medicalNewsVc = [[MedicalNewsDetailViewController alloc] init];
    MedicaNewsModel *model = self.modelArray[indexPath.item];
    medicalNewsVc.id = model.id;
    NSLog(@"%@",model.id);
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:YES];
    [self.navigationController pushViewController:medicalNewsVc animated:NO];
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
