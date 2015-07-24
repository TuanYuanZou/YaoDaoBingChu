//
//  HealthLectureViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "HealthLectureViewController.h"
#import "HealthLectureModel.h"
#import "HealthLectureCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "HealthLectureDetailViewController.h"
#import "HealthLectureCollectionReusableView.h"

#define HealthLectureURL @"http://phone.vodjk.com/home.php?userid="

@interface HealthLectureViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *totalArray;

@end

@implementation HealthLectureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestDataOfHealthLecture];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 70) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
//    BackImageView *backImageView = [[BackImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) image:@"view.jpg"];
//    self.collectionView.backgroundView = backImageView;

    [self.collectionView registerClass:[HealthLectureCollectionViewCell class] forCellWithReuseIdentifier:@"healthLectureCell"];
    
    [self.collectionView registerClass:[HealthLectureCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"healthLectureView"];
    
    [self.view addSubview:_collectionView];
}

- (void)requestDataOfHealthLecture
{
    [LORequestManger GET:HealthLectureURL success:^(id response)
    {
        self.totalArray = [NSMutableArray array];
        NSDictionary *dict = (NSDictionary *)response;
        NSDictionary *dict1 = dict[@"result"];
        NSArray *sectionArray = @[dict1[@"section1"],dict1[@"section2"],dict1[@"section3"],dict1[@"section4"],dict1[@"section5"]];
        for (NSDictionary *dict2 in sectionArray)
        {
            NSArray *array = dict2[@"data"];
            NSMutableArray *array2 = [NSMutableArray array];
            for (NSDictionary *dict3 in array)
            {
                HealthLectureModel *model = [[HealthLectureModel alloc] init];
                [model setValuesForKeysWithDictionary:dict3];
                [array2 addObject:model];
            }
            [self.totalArray addObject:array2];
        }
        [self.collectionView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.totalArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HealthLectureCollectionViewCell *healthLectureCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"healthLectureCell" forIndexPath:indexPath];
    HealthLectureModel *model = [self.totalArray[indexPath.section] objectAtIndex:indexPath.item];
    [healthLectureCell setValueForCellWithModel:model];
    return healthLectureCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HealthLectureCollectionReusableView *healthLectureView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"healthLectureView" forIndexPath:indexPath];
    switch (indexPath.section)
    {
        case 0:
            healthLectureView.titleLabel.text = @"最新推荐";
            break;
        case 1:
            healthLectureView.titleLabel.text = @"生活";
            break;
        case 2:
            healthLectureView.titleLabel.text = @"养生";
            break;
        case 3:
            healthLectureView.titleLabel.text = @"疾病";
            break;
        case 4:
            healthLectureView.titleLabel.text = @"母婴";
            break;
            
        default:
            break;
    }
    return healthLectureView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 40);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(165, 150);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HealthLectureModel *model = [self.totalArray[indexPath.section] objectAtIndex:indexPath.item];
    HealthLectureDetailViewController *healthLectureVc = [[HealthLectureDetailViewController alloc] init];
    healthLectureVc.model = model;
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:YES];
    
    [self.navigationController pushViewController:healthLectureVc animated:NO];
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
