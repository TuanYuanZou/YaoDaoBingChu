//
//  YDPartnerController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "YDPartnerController.h"
#import "YDNiMeiDeCell.h"
#import "YDPartnerModel.h"
#import "YDPartnerDetailController.h"

@interface YDPartnerController ()

@end

@implementation YDPartnerController

static NSString * const reuseIdentifier = @"nimeide";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT / 4.5);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return [self initWithCollectionViewLayout:layout];
}
- (void)left {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"品牌";
    self.view.userInteractionEnabled = YES;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    left.image = [UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem = left;
    
   
    [self.collectionView registerNib:[UINib nibWithNibName:@"YDNiMeiDeCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.PartnerArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDNiMeiDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    YDPartnerModel *model = self.PartnerArray[indexPath.item];
    
    [cell setModel:model];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YDPartnerDetailController *deParVc = [[YDPartnerDetailController alloc] init];
    YDPartnerModel *model = self.PartnerArray[indexPath.item];

    deParVc.name = model.namecn;
    [self.navigationController pushViewController:deParVc animated:YES];
}

@end
