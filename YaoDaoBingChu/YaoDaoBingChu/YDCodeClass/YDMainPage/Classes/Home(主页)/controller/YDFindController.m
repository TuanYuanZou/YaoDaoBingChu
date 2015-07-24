//
//  YDFindController.m
//  text
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import "YDFindController.h"
#import "YDGroupModel.h"
#import "YDPartnerDetailModel.h"
#import "YDPartnerDetailController.h"
@interface YDFindController ()

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSArray *groupArray;


@end

@implementation YDFindController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"对症找药";
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    left.image = [UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem = left;
    
    [self groups];

}

- (void)left {
    [self.navigationController popViewControllerAnimated:YES];
}




- (NSMutableArray *)groups
{
    if (_groups == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DrugSearch.plist" ofType:nil];
    
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];

        _groupArray = [[dict allKeys] sortedArrayUsingSelector:@selector(compare:)];
        
        NSMutableArray *all = [NSMutableArray array];  // 大
        
        for (NSString *key in _groupArray) {
            
            NSArray *values = [dict objectForKey:key];
            
            NSMutableArray *temp = [NSMutableArray array];
            
            for (NSString *str in values) {
                
                YDGroupModel *model = [[YDGroupModel alloc] init];
                model.name = str;
                
                [temp addObject:model];
            }
            [all addObject:temp];
        }
        _groups = all;
    }
    return _groups;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_groups[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellInentifier=@"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellInentifier];
    }
    YDGroupModel *model = [_groups[indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_groupArray objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _groupArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YDPartnerDetailController *pdVc = [[YDPartnerDetailController alloc] init];
    YDGroupModel *model = [_groups[indexPath.section] objectAtIndex:indexPath.row];
    pdVc.name = model.name;
    [self.navigationController pushViewController:pdVc animated:YES];
}
@end
