//
//  YDDetailedRouteTableViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDDetailedRouteTableViewController.h"
#import <MapKit/MapKit.h>

@interface YDDetailedRouteTableViewController ()

@end

@implementation YDDetailedRouteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    MKRoute * route = [self.routes lastObject] ;
    
    return route.steps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIndentifer = @"cell" ;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifer] ;
    }
    MKRoute * route = (MKRoute *)[self.routes lastObject];
    MKRouteStep * step = (MKRouteStep *)route.steps[indexPath.row] ;
    
    cell.textLabel.text = step.instructions;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f",step.distance / 1000.0f]    ;
    
    return cell;
}


@end
