//
//  YDRouterSelectViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDRouterSelectViewController.h"
#import <MapKit/MapKit.h>
#import "YDAnnotation.h"
#import "YDAnnotationView.h"
#import "YDDetailedRouteTableViewController.h"

@interface YDRouterSelectViewController ()<MKMapViewDelegate>

//  地图
@property(nonatomic,strong)MKMapView * mapView ;
//  地理编码
@property(nonatomic,strong)CLGeocoder * geocoder ;
//  保存检索到的路线
@property(nonatomic,strong)NSArray * routes ;

@end

@implementation YDRouterSelectViewController
#pragma mark - 懒加载
- (MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MKMapView alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
        _mapView.delegate = self ;
        [self.view addSubview:_mapView] ;
    }
    return _mapView ;
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init] ;
    }
    return _geocoder ;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  获取用户起始地标
    [self obtainUserStartPlacemarkEndPlacemark];
    
    //  导航栏右按钮
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(rightBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButton ;
    
    
}


#pragma mark- 获取用户起始坐标
- (void)obtainUserStartPlacemarkEndPlacemark
{
    
    [self.geocoder geocodeAddressString:self.startAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0) {
            UIAlertView * startAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"起点地标获取失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
            [startAlertView show] ;
            return ;
        }
        CLPlacemark * startCLPlacemark = [placemarks lastObject] ;
        
        //  添加起点大头针
        YDAnnotation * startAnnotation = [[YDAnnotation alloc]init] ;
        startAnnotation.title = startCLPlacemark.locality ;
        startAnnotation.subtitle = startCLPlacemark.name ;
        startAnnotation.coordinate = startCLPlacemark.location.coordinate ;
        startAnnotation.icon = [UIImage imageNamed:@"start-marker.png"];
#warning 起点图标
        [self.mapView addAnnotation:startAnnotation] ;
        
        [self.geocoder geocodeAddressString:self.endAddress completionHandler:^(NSArray *placemarks, NSError *error) {
            
            if (placemarks.count == 0) {
                UIAlertView * endAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"终点地标获取失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
                [endAlertView show] ;
                return ;
            }
            CLPlacemark * endCLPlacemark = [placemarks lastObject] ;
            
            //  添加终点大头针
            YDAnnotation * endAnnotation = [[YDAnnotation alloc]init] ;
            endAnnotation.title = endCLPlacemark.locality ;
            endAnnotation.subtitle = endCLPlacemark.name ;
            endAnnotation.coordinate = endCLPlacemark.location.coordinate ;
            endAnnotation.icon = [UIImage imageNamed:@"end-marker.png"];
#warning 终点图标
            [self.mapView addAnnotation:endAnnotation] ;
            
            // 开始获取路线信息
            [self startGetRouteWithStatCLPlacemark:startCLPlacemark endCLPlacemark:endCLPlacemark];
            
        }] ;
    }] ;
}


#pragma mark 开始获取路线信息
- (void)startGetRouteWithStatCLPlacemark:(CLPlacemark *)startCLPlacemark endCLPlacemark:(CLPlacemark *)endCLPlacemark
{
    //  1.创建起点和 终点对象
    MKPlacemark * startMKPlacemark = [[MKPlacemark alloc]initWithPlacemark:startCLPlacemark] ;
    MKMapItem * startItem = [[MKMapItem alloc]initWithPlacemark:startMKPlacemark] ;
    
    MKPlacemark * endMKPlacemark = [[MKPlacemark alloc]initWithPlacemark:endCLPlacemark] ;
    MKMapItem * endItem = [[MKMapItem alloc]initWithPlacemark:endMKPlacemark] ;
    
    //  2.创建请求对象
    MKDirectionsRequest * request = [[MKDirectionsRequest alloc]init] ;
    //  2.1 起点
    request.source = startItem ;
    //  2.2 终点
    request.destination = endItem ;
    
    //  3.发送请求
    MKDirections * direction = [[MKDirections alloc]initWithRequest:request] ;
    
    //  4.获取路线
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        //  所有路线
        NSArray * routes = response.routes ;
        self.routes = routes ;
        NSLog(@"%ld",routes.count) ;
        for (MKRoute * route in routes) {
            //  5.绘制路线
            [self.mapView addOverlay:route.polyline] ;
            for (MKRouteStep * step  in route.steps) {
                NSLog(@"%@-----%f",step.instructions,step.distance) ;
            }
        }
        
    }];
    
}



#pragma mark - 绘制路线时调用（添加覆盖时调用）
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer * line = [[MKPolylineRenderer alloc]initWithOverlay:overlay] ;
    line.lineWidth = 5 ;
    line.strokeColor = [UIColor blueColor] ;
    
    //   返回路线
    return line ;
}

#pragma mark - 每次添加大头针时都会调用该方法（类比cell）
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //   用户当前位置大头针特殊处理(使用默认大头针)
    if ([annotation isKindOfClass:[YDAnnotation class]] == NO) {
        return nil ;
    }
    //  1.创建大头针
    YDAnnotationView * annotationView = [YDAnnotationView annotationViewWithMap:mapView] ;
    //  2.为大头针视图设置数据模型
    annotationView.annotation = annotation ;
    //  3.返回大头针
    return annotationView ;
    
}


#pragma mark - 导航栏右按钮
- (void)rightBarButtonAction:(UIBarButtonItem *)sender
{
    if (self.routes.count == 0) {
        UIAlertView * AlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未搜索到路线" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
        [AlertView show] ;
        return ;
    }
    YDDetailedRouteTableViewController * detailedRouteTableVc = [[YDDetailedRouteTableViewController alloc]init] ;
    detailedRouteTableVc.routes = self.routes ;
    [self.navigationController pushViewController:detailedRouteTableVc animated:YES] ;
    
}
















@end
